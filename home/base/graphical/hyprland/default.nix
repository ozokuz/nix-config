{ pkgs, pkgs-unstable, hyprsome, ... }:
let
  scripts = pkgs.callPackage ../../../../pkgs/scripts.nix {};
in 
{
  imports = [
    ./workspaces.nix
    ./environment.nix
    ./input.nix
    ./windowrules.nix
    ./services.nix
    ./statusbar.nix
    ./theming.nix
  ];

  home.packages = with pkgs; [
    hyprpaper
    tofi
    libnotify
    wl-clipboard
    wl-clip-persist
    playerctl
    bc
    avizo
    emote
    wtype
    syncthingtray
    scripts.ode-awake-toggle
    scripts.ode-toggle-widget
    scripts.ode-lock
    scripts.scrsht
    hyprsome.packages.${pkgs.system}.default
  ]; 

  wayland.windowManager.hyprland = {
    enable = true;
    systemd = {
       enable = true;
       variables = ["--all"];
    };
    settings = {
      general = {
        allow_tearing = true;

        gaps_in = 5;
        gaps_out = 20;
        border_size = 2;
        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";

        layout = "dwindle";
      };

      decoration = {
        rounding = 10;

        blur = {
          enabled = true;
          size = 3;
          passes = 1;
        };

        drop_shadow = false;
      };

      animations = {
        enabled = true;

        bezier = ["myBezier, 0.05, 0.9, 0.1, 1.05"];
        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };

      xwayland.force_zero_scaling = true;
    };
  };

  home.file.".local/wallpaper.png".source = ./wallpaper.png;
  xdg.configFile."hypr/hyprpaper.conf".source = ../configs/hyprpaper.conf;

  xdg.configFile."tofi/config".source = ../configs/tofi/config;

  xdg.userDirs = {
    enable = true;
    createDirectories = true;
  };

  xdg.mimeApps = {
      enable = false;
      defaultApplications = {
          "text/plain" = ["nvim.desktop"];
          "x-scheme-handler/http" = ["brave-browser.desktop"];
          "x-scheme-handler/https" = ["brave-browser.desktop"];
          "x-scheme-handler/webcal" = ["brave-browser.desktop"];
          "text/html" = ["brave-browser.desktop"];
          "application/pdf" = ["org.pwmt.zathura.desktop"];
          "inode/directory" = ["org.gnome.Nautilus.desktop"];
          "x-scheme-handler/jetbrains" = ["JetBrains Toolbox.desktop"];
        };
    };
}
