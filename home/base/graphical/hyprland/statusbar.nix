{
  pkgs,
  pkgs-unstable,
  ...
}: let
  scripts = pkgs.callPackage ../../../../pkgs/scripts.nix {};
in {
  programs.waybar = {
    enable = true;
    package = pkgs-unstable.waybar;
    settings = {
      mainBar = {
        position = "top";
        layer = "top";
        height = 36;
        spacing = 8;
        margin-top = 8;
        margin-left = 0;
        margin-right = 0;
        modules-left = ["hyprland/workspaces" "hyprland/window"];
        modules-center = ["mpris"];
        modules-right = ["tray" "group/hardware" "clock"];
        "custom/awake" = {
          format = "{} ";
          exec = "${scripts.ode-awake-status}/bin/ode_awake_status";
          interval = "once";
          on-click = "${scripts.ode-awake-toggle}/bin/ode_awake_toggle";
          signal = 8;
        };
        "custom/weather" = {
          format = "{}   ";
          exec = "${scripts.ode-weather-status}/bin/ode_weather_status";
          interval = 3600;
          return-type = "json";
        };
        "group/hardware" = {
          orientation = "horizontal";
          modules = ["hyprland/submap" "hyprland/language" "custom/weather" "custom/awake" "wireplumber" "network" "battery"];
        };
        "hyprland/window".separate-outputs = true;
        "mpris" = {
          player = "spotify";
          format = "{status_icon}   {artist} - {title}";
          tooltip-format = "";
          status-icons = {
            playing = "󰐍";
            paused = "󰏦";
            stopped = "󰙧";
          };
          on-click = "ode_toggle_widget music";
        };
        tray.spacing = 8;
        "hyprland/language" = {
          format = {};
          format-fi = "🇫🇮  ";
          format-en = "🇺🇸  ";
        };
        "hyprland/submap".format = "{}   ";
        wireplumber = {
          format = "{icon}";
          format-icons = ["" "" ""];
        };
        network = {
          format = "󰖩 ";
          format-disconnected = "󰖪 ";
        };
        battery = {
          interval = 5;
          format = "{icon}";
          format-time = "{H}h {M}min left";
          format-icons = ["󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
          "format-not charging" = "󱉝";
          format-charging = "󰂄";
          tooltip-format = "{timeTo} - {capacity}%";
        };
        clock = {
          format = "{:%a, %d.%m.%y | %H:%M:%S}";
          interval = 1;
          on-click = "ode_toggle_widget calendar";
        };
      };
    };
    systemd.enable = true;
    style = ../configs/waybar/style.css;
  };
}
