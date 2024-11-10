#!/usr/bin/env node
const { argv, exit, env } = require("process");
const { execSync } = require("child_process");
const { writeFile } = require("fs/promises");
const { existsSync, readFileSync } = require("fs");

const help = `hyprkbctl 0.1.0 - Set hyprland keyboard layout

Usage: hyprkbctl [operation] [value]

Operations:
  g, get        Get the current keyboard layout
  n, next       Change to the next keyboard layout
`;

const named = {
  Finnish: "fi",
  "English (US)": "us",
};

const FILE = "/tmp/hyprkb_layout";

const write = (value) => writeFile(FILE, value, "utf-8");

async function main() {
  let operation = "";

  switch (argv[2]) {
    case "g":
    case "get":
      operation = "get";
      break;
    case "n":
    case "next":
      operation = "next";
      break;
    default:
      console.log(help);
      exit(1);
  }

  const keyboard = readFileSync(`/home/${env.USER}/.local/keyboard`, "utf-8");
  const devices = JSON.parse(execSync("hyprctl devices -j"));
  const current = devices.keyboards.find((k) => k.name === keyboard);

  const layouts = current.layout.split(",");
  let active = named[current.active_keymap];

  if (!existsSync(FILE)) {
    await write(active);
  }

  switch (operation) {
    case "get":
      console.log(active);
      break;
    case "next":
      const next = layouts[(layouts.indexOf(active) + 1) % layouts.length];
      const a = write(next);
      execSync(`hyprctl switchxkblayout ${keyboard} next`);
      await a;
      break;
  }
}

main();
