{ pkgs, lib, ... }:
let
  scripts = pkgs.callPackage ../../../../pkgs/scripts.nix {};
in 
{
  # Notifications
  services.mako = {
    enable = true;
    font = "Noto Sans 10";
    backgroundColor = "#000000BB";
    borderSize = 0;
    borderRadius = 8;
    defaultTimeout = 5000;
    ignoreTimeout = true;
    margin = "20";
  };

  # Popup Widgets
  programs.eww = {
    enable = true;
    configDir = ../configs/eww;
    package = pkgs.eww-wayland;
  };

  systemd.user.services.eww = {
    Unit = { Description = "Widget system"; };
    Service = {
      Type = "exec";
      ExecStart = "${pkgs.eww-wayland}/bin/eww daemon --no-daemonize";
      Restart = "on-failure";
      Environment = "\"PATH=${with pkgs; lib.makeBinPath [systemd scripts.ode-toggle-widget bash hyprland eww-wayland]}\"";
    };
    Install = { WantedBy = ["graphical-session.target"]; };
  };

  # Volume / Brightness OSD
  services.avizo.enable = true;

  # Idle Manager
  services.swayidle = {
    enable = true;
    timeouts = [
      { timeout = 900; command = "${pkgs.swaylock-effects}/bin/swaylock --grace 5 -i /home/ozoku/.local/wallpaper.png"; }
      { timeout = 915; command = "${pkgs.hyprland}/bin/hyprctl dispatch dpms off"; resumeCommand = "${pkgs.hyprland}/bin/hyprctl dispatch dpms on"; }
      { timeout = 1200; command = "${pkgs.systemd}/bin/systemctl suspend"; }
    ];
    events = [
      { event = "before-sleep"; command = "${pkgs.playerctl}/bin/playerctl pause"; }
      { event = "before-sleep"; command = "${pkgs.swaylock-effects}/bin/swaylock -i /home/ozoku/.local/wallpaper.png"; }
    ];
  };

  # Color Temperature
  services.gammastep = {
    enable = true;
    dawnTime = "6:00-8:00";
    duskTime = "21:30-22:30";
    provider = "manual";
    temperature = {
      day = 5500;
      night = 3700;
    };
    tray = true;
  };

  # Secrets Provider
  services.gnome-keyring = {
    enable = true;
    components = ["secrets" "ssh"];
  };

  # Phone Integration
  services.kdeconnect = {
    enable = true;
    indicator = true;
  };

  # Media Player Info Daemon
  services.playerctld.enable = true;

  # Device Auto Mount
  services.udiskie.enable = true;

  # Bluetooth Manager
  services.blueman-applet.enable = true;

  # Network Manager
  services.network-manager-applet.enable = true;
}
