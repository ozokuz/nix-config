{ ... }:
{
  wayland.windowManager.hyprland.settings = {
    input = {
      # Keyboard
      kb_layout = "fi,us";

      numlock_by_default = true;

      repeat_rate = 30;
      repeat_delay = 500;

      # Mouse
      follow_mouse = 1;

      touchpad = {
        natural_scroll = "no";
      };

      sensivity = 0;
    };

    "$mod" = "SUPER";
    bind = [
      ## System
      # Powermenu
      "$mod SHIFT, Q, exec, ode_toggle_widget powermenu"
      # App Launcher
      "$mod, space, exec, tofi-drun | xargs hyprctl dispatch exec --"
      # Script Runner
      "$mod SHIFT, space, exec, ls ~/.local/bin | tofi | xargs hyprctl dispatch exec --"
      # Screen Lock
      "$mod, X, exec, swaylock"
      # Overlay Audio Mixer
      "$mod, A, togglespecialworkspace, audiomixer"
      # Overlay Network Manager
      "$mod SHIFT, W, togglespecialworkspace, networkmanager"
      # Switch Keyboard Layout
      "$mod, B, exec, hyprctl switchxkblayout, ckb1:-corsair-k95-rgb-gaming-keyboard-vkb next"
      # Scratchpad
      "$mod, minus, togglespecialworkspace, scratchpad"
      # Overlay Resource Monitor
      "$mod, R, togglespecialworkspace, processes"

      ## Apps
      # Terminal
      "$mod, return, exec, $TERMINAL"
      # Terminal File Manager
      "$mod, E, exec, $TERMINAL -e lf"
      # GUI File Manager
      "$mod SHIFT, exec, nautilus -w"
      # Web Browser
      "$mod, W, exec, $BROWSER"
      # Overlay 2FA
      "$mod, S, togglespecialworkspace, 2fa"

      ## Music
      # Play/Pause
      ", XF86AudioPlay, exec, playerctl -p spotify play-pause"
      # Previous
      ", XF86AudioPrev, exec, playerctl -p spotify previous"
      # Next
      ", XF86AudioNext, exec, playerctl -p spotify next"
      # Raise Volume
      ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%+"
      # Lower Volume
      ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%-"
      # Mute
      ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"

      ## Window
      # Close
      "$mod, Q, killactive"
      # Toggle Float
      "$mod, F, togglefloating"

      ## Screenshot
      # Area
      "$superKey, less, exec, scrsht area"
      # Current Window
      "$superKey SHIFT, less, exec, scrsht window"
      # Current Screen
      "$superKey ALT, less, exec, scrsht screen"

      # Move focus with Super + hjkl
      "$superKey, h, movefocus, l"
      "$superKey, j, movefocus, d"
      "$superKey, k, movefocus, u"
      "$superKey, l, movefocus, r"

      # Switch workspaces with superKey + [0-9]
      "$superKey, 1, exec, hyprsome workspace 1"
      "$superKey, 2, exec, hyprsome workspace 2"
      "$superKey, 3, exec, hyprsome workspace 3"
      "$superKey, 4, exec, hyprsome workspace 4"
      "$superKey, 5, exec, hyprsome workspace 5"
      "$superKey, 6, exec, hyprsome workspace 6"
      "$superKey, 7, exec, hyprsome workspace 7"
      "$superKey, 8, exec, hyprsome workspace 8"
      "$superKey, 9, exec, hyprsome workspace 9"

      # Move active window to a workspace with superKey + SHIFT + [0-9]
      "$superKey SHIFT, 1, exec, hyprsome move 1"
      "$superKey SHIFT, 2, exec, hyprsome move 2"
      "$superKey SHIFT, 3, exec, hyprsome move 3"
      "$superKey SHIFT, 4, exec, hyprsome move 4"
      "$superKey SHIFT, 5, exec, hyprsome move 5"
      "$superKey SHIFT, 6, exec, hyprsome move 6"
      "$superKey SHIFT, 7, exec, hyprsome move 7"
      "$superKey SHIFT, 8, exec, hyprsome move 8"
      "$superKey SHIFT, 9, exec, hyprsome move 9"

      # Move active window to special workspace
      "$superKey SHIFT, minus, movetoworkspacesilent, special"

      # Global Shortcuts
      # Discord
      ",code:201,pass,^discord$"
      ",code:202,pass,^discord$"
    ];

    bindm = [
      # Move/resize windows with superKey + LMB/RMB and dragging
      "$superKey, mouse:272, movewindow"
      "$superKey, mouse:273, resizewindow"
    ];

    extraConfig = ''
      # Temp Hotkey Disabling
      bind = $superKey ALT SHIFT, p, submap, disabled

      submap = disabled

      bind = $superKey, escape, submap, reset

      submap = reset
    '';
  };
}

