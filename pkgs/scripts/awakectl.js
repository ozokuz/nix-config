import { argv, exit } from "node:process";
import { spawn, execSync } from "node:child_process";
import { readFile, writeFile } from "node:fs/promises";
import { existsSync } from "node:fs";

const help = `awakectl 0.1.0 - Set system awake status

Usage: awakectl [operation] [value]

Operations:
  g, get            Get the system awake status
  t, toggle         Toggle the system awake status
  s, set VALUE      Set the system awake status
`;

console.log(argv);
exit(0);

let operation = "";

switch (argv[2]) {
  case "g":
  case "get":
    operation = "get";
    break;
  case "t":
  case "toggle":
    operation = "toggle";
    break;
  case "s":
  case "set":
    operation = "set";
    break;
  default:
    console.log(help);
    exit(1);
}

const FILE = "/tmp/awake_status";

const write = (status) => writeFile(FILE, status ? "1" : "0", "utf-8");
const read = async () => readFile(FILE, "utf-8");
const getStatus = async () => {
  let awake = false;
  try {
    execSync("pgrep -x awakeidler");
    awake = true;
  } catch {}

  return awake;
};

let awake = false;
if (!existsSync(FILE)) {
  awake = await getStatus();
  await write(awake);
} else {
  awake = (await read()) === "1";
}

const set = async (newStatus) => {
  const currentStatus = await getStatus();
  if (newStatus === currentStatus) return;

  if (newStatus) {
    spawn(
      `systemd-inhibit --who=awakeidler --why="Prevent idling" --what=idle --mode=block perl -MPOSIX -e '$0="awakeidler"; pause'`,
    );
  } else {
    execSync("killall awakeidler");
  }
};

switch (operation) {
  case "get":
    console.log(awake ? "keep-awake" : "allow-sleep");
    break;
  case "toggle":
    awake = !awake;
    await write(awake);
    break;
  case "set":
    awake = argv[3] === "keep-awake";
    await write(awake);
    break;
}
