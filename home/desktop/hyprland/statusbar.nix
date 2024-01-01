{ ... }:
{
  programs.waybar = {
    enable = true;
    settings = {
      position = "top";
      layer = "top";
      height = 36;
      spacing = 16;
      margin-top = 20;
      margin-left = 20;
      margin-right = 20;
      modules-left = ["hyprland/workspaces" "hyprland/window"];
      modules-center = ["mpris"];
      modules-right = ["tray" "group/hardware" "clock"];
      "group/hardware" = {
        orientation = "horizontal";
        modules = ["hyprland/submap" "hyprland/language" "network"];
      };
      "hyprland/workspaces" = {
        format = "{icon}";
        format-icons = {
          "11" = "1";
          "12" = "2";
          "13" = "3";
          "14" = "4";
          "15" = "5";
          "16" = "6";
          "17" = "7";
          "18" = "8";
          "19" = "9";
        };
        persistent-workspaces = {
          DP-2 = [1 2 3 4 5 6 7 8 9];
          DP-3 = [11 12 13 14 15 16 17 18 19];
        };
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
        format-us = "us";
      };
      "hyprland/submap".format = "{}   ";
      wireplumber = {
        format = "{icon}";
        format-icons = ["" "" ""];
      };
      network.format = "{essid}   ";
      clock = {
        format = "{:%a, %b %d | %H:%M:%S}";
        interval = 1;
        on-click = "ode_toggle_widget calendar";
      };
    };
    systemd.enable = true;
    style = ../configs/waybar/style.css;
  };
}
