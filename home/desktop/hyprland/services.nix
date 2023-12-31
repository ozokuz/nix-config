{ pkgs, ... }:
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
    components = ["secrets"];
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
}
