{ ... }:
{
  wayland.windowManager.hyprland = {
    settings = {
      input = {
        # Keyboard
        kb_layout = "fi,us";
        kb_options = "caps:escape";

        numlock_by_default = true;

        repeat_rate = 30;
        repeat_delay = 500;

        # Mouse
        follow_mouse = 1;

        touchpad = {
          natural_scroll = true;
          scroll_factor = 0.2;
        };

        sensitivity = 0;
      };

      gestures.workspace_swipe = true;

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
        "$mod, X, exec, ode_lock"
        # Overlay Audio Mixer
        "$mod, A, togglespecialworkspace, audiomixer"
        # Overlay Network Manager
        "$mod SHIFT, W, togglespecialworkspace, networkmanager"
        # Switch Keyboard Layout
        "$mod, B, exec, hyprctl switchxkblayout, at-translated-set-2-keyboard next"
        # Scratchpad
        "$mod, minus, togglespecialworkspace, scratchpad"
        # Overlay Resource Monitor
        "$mod, R, togglespecialworkspace, processes"
        # Emoji Picker
        "$mod, period, exec, emote"

        ## Apps
        # Terminal
        "$mod, return, exec, $TERMINAL"
        # Terminal File Manager
        "$mod, E, exec, $TERMINAL -e lf"
        # GUI File Manager
        "$mod SHIFT, E, exec, nautilus -w"
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
        ", XF86AudioRaiseVolume, exec, volumectl -u up"
        # Lower Volume
        ", XF86AudioLowerVolume, exec, volumectl -u down"
        # Mute
        ", XF86AudioMute, exec, volumectl toggle-mute"
        # Mic Mute
        ", XF86AudioMicMute, exec, volumectl -m toggle-mute"

        ## Display
        # Raise Brightness
        ", XF86MonBrightnessUp, exec, lightctl up"
        # Lower Brightness
        ", XF86MonBrightnessDown, exec, lightctl down"
        # Toggle Wifi
        ", XF86RFKill, exec, rfkill toggle 0"

        ## Window
        # Close
        "$mod, Q, killactive"
        # Toggle Float
        "$mod, F, togglefloating"

        ## Screenshot
        # Area
        "$mod, less, exec, scrsht area"
        # Current Window
        "$mod SHIFT, less, exec, scrsht window"
        # Current Screen
        "$mod ALT, less, exec, scrsht screen"

        # Move focus with Super + hjkl
        "$mod, h, movefocus, l"
        "$mod, j, movefocus, d"
        "$mod, k, movefocus, u"
        "$mod, l, movefocus, r"

        # Switch workspaces with mod + [0-9]
        "$mod, 1, exec, hyprsome workspace 1"
        "$mod, 2, exec, hyprsome workspace 2"
        "$mod, 3, exec, hyprsome workspace 3"
        "$mod, 4, exec, hyprsome workspace 4"
        "$mod, 5, exec, hyprsome workspace 5"
        "$mod, 6, exec, hyprsome workspace 6"
        "$mod, 7, exec, hyprsome workspace 7"
        "$mod, 8, exec, hyprsome workspace 8"
        "$mod, 9, exec, hyprsome workspace 9"

        # Move active window to a workspace with mod + SHIFT + [0-9]
        "$mod SHIFT, 1, exec, hyprsome move 1"
        "$mod SHIFT, 2, exec, hyprsome move 2"
        "$mod SHIFT, 3, exec, hyprsome move 3"
        "$mod SHIFT, 4, exec, hyprsome move 4"
        "$mod SHIFT, 5, exec, hyprsome move 5"
        "$mod SHIFT, 6, exec, hyprsome move 6"
        "$mod SHIFT, 7, exec, hyprsome move 7"
        "$mod SHIFT, 8, exec, hyprsome move 8"
        "$mod SHIFT, 9, exec, hyprsome move 9"

        # Move active window to special workspace
        "$mod SHIFT, minus, movetoworkspacesilent, special"

        # Global Shortcuts
        # Discord
        ",code:201,pass,^discord$"
        ",code:202,pass,^discord$"
      ];

      bindm = [
        # Move/resize windows with mod + LMB/RMB and dragging
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];
    };

    extraConfig = ''
      # Temp Hotkey Disabling
      bind = $mod ALT SHIFT, p, submap, disabled

      submap = disabled

      bind = $mod, escape, submap, reset

      submap = reset
    '';
  };
}

