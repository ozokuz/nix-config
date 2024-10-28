{pkgs, ...}: {
  imports = [
    ../common
    ./environment.nix
    ./input.nix
    ./services.nix
    ./windowrules.nix
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
  ];

  ozoku = {
    graphics.enable = true;

    workspaces = 6;

    waybar.enable = true;

    hyprland = {
      enable = true;

      package = pkgs.unstable.hyprland;

      workspaces = {
        perDisplay = true;

        primaryModifier = "SUPER";
        secondaryModifier = "SHIFT";

        special = {
          pwmanager = {
            exec = "bitwarden";
            keybind = "SUPER, S";
          };
          processes = {
            exec = "$TERMINAL -e btop";
            keybind = "SUPER, R";
          };
          audiomixer = {
            exec = "$TERMINAL -e pulsemixer";
            keybind = "SUPER, A";
          };
          scratchpad = {
            exec = "$TERMINAL";
            keybind = "SUPER, minus";
          };
          networkmanager = {
            exec = "$TERMINAL -e nmtui";
            keybind = "SUPER SHIFT, W";
          };
        };
      };
    };
  };

  wayland.windowManager.hyprland.settings = {
    general = {
      allow_tearing = true;

      gaps_in = 5;
      gaps_out = 8;
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

  home.file.".local/wallpaper.png".source = ../../../wallpaper.png;
  xdg.configFile."hypr/hyprpaper.conf".source = ../../../configs/hyprpaper.conf;
  xdg.configFile."tofi/config".source = ../../../configs/tofi/config;
}
