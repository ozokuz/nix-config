{ pkgs, pkgs-unstable, lib, ... }:
let
  obsidian-fixed = lib.throwIf (lib.versionOlder "1.4.16" pkgs.obsidian.version) "Obsidian no longer requires EOL Electron" (
    pkgs.obsidian.override {
      electron = pkgs.electron_25.overrideAttrs (_: {
        preFixup = "patchelf --add-needed ${pkgs.libglvnd}/lib/libEGL.so.1 $out/bin/electron"; # NixOS/nixpkgs#272912
        meta.knownVulnerabilities = [ ]; # NixOS/nixpkgs#273611
      });
    }
  );
in
{
  home.packages = with pkgs; [
    brave
    firefox
    floorp
    spotify
    bitwarden
    authy
    pulsemixer
    alsa-utils
    nvtop
    nsxiv
    gnome.nautilus
    gnome.sushi
    discord
    nautilus-open-any-terminal
    obsidian-fixed
    podman-desktop
    distrobox
    pkgs-unstable.vscode-fhs
    pkgs-unstable.jetbrains-toolbox
    pkgs-unstable.gitkraken
    pkgs-unstable.vesktop
  ];

  programs.alacritty = {
    enable = true;
    settings = {
      window.opacity = 0.9;
      font = {
        normal.family = "FiraCode Nerd Font";
        size = 11;
      };
      cursor.style = {
        shape = "Block";
        blinking = "On";
      };
      mouse.hide_when_typing = true;
      hints.enabled = [{
        regex = "(mailto:|https:|http:|file:|git:|ssh:|ftp:)[^\\u0000-\\u001F\\u007F-\\u009F<>\"\\\\s{-}\\\\^⟨⟩`]+";
        command = "xdg-open";
        post_processing = true;
        mouse.enabled = true;
      }];
    };
  };

  programs.kitty.enable = true;

  programs.mpv.enable = true;
  programs.zathura.enable = true;
}
