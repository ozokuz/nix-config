{
  pkgs,
  config,
  lib,
  ...
}: {
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
    configDir = ../../../configs/eww;
  };

  systemd.user.services.eww = {
    Unit = {Description = "Widget system";};
    Service = {
      Type = "exec";
      ExecStart = "${pkgs.eww}/bin/eww daemon --no-daemonize";
      Restart = "on-failure";
      Environment = "\"PATH=${with pkgs; lib.makeBinPath [systemd custom.scripts.ode-toggle-widget bash hyprland eww]}\"";
    };
    Install = {WantedBy = ["graphical-session.target"];};
  };

  # Wallpaper
  services.hyprpaper = {
    enable = true;

    settings = let
      wallpaper = "/home/${config.home.username}/.local/wallpaper.png";
    in {
      preload = [wallpaper];
      wallpaper = [",${wallpaper}"];
    };
  };

  # Volume / Brightness OSD
  services.avizo.enable = true;

  # Color Temperature
  services.gammastep = {
    enable = true;
    dawnTime = "6:00-8:00";
    duskTime = "21:30-22:30";
    provider = "manual";
    temperature = {
      day = 6500;
      night = 3000;
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

  # Syncthing
  services.syncthing.enable = true;
}
