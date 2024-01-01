{ pkgs, hyprsome, ... }:
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
    grim
    slurp
    jq
    xdg-user-dirs
    wl-clipboard
    wl-clip-persist
    playerctl
    bc
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
    };
  };

  home.file.".local/wallpaper.png".source = ./wallpaper.png;
  xdg.configFile."hypr/hyprpaper.conf".source = ../configs/hyprpaper.conf;

  xdg.configFile."tofi/config".source = ../configs/tofi/config;

  home.file.".local/bin/ode_toggle_widget".source = ./scripts/ode_toggle_widget;
  home.file.".local/bin/scrsht".source = ./scripts/scrsht;
}
