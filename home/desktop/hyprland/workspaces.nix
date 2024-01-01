{ ... }:
{
  wayland.windowManager.hyprland.settings = {
    monitor = [
      # Main Monitor 
      "DP-2, 2560x1440@144, 2560x0, 1"
      # Side Monitor
      "DP-3, 2560x1440@60, 0x0, 1"
    ];

    workspace = [
      # Starting Workspaces
      # Main Monitor
      "DP-2, 1"
      # Side Monitor
      "DP-3, 11"

      # Workspace Definitions
      # Main Monitor
      "1, monitor:DP-2"
      "2, monitor:DP-2"
      "3, monitor:DP-2"
      "4, monitor:DP-2"
      "5, monitor:DP-2"
      "6, monitor:DP-2"
      "7, monitor:DP-2"
      "8, monitor:DP-2"
      "9, monitor:DP-2"
      "10, monitor:DP-2"

      # Side Monitor
      "11, monitor:DP-3"
      "12, monitor:DP-3"
      "13, monitor:DP-3"
      "14, monitor:DP-3"
      "15, monitor:DP-3"
      "16, monitor:DP-3"
      "17, monitor:DP-3"
      "18, monitor:DP-3"
      "19, monitor:DP-3"
      "20, monitor:DP-3"

      # Special Workspaces
      "special:2fa, on-created-empty:authy"
      "special:processes, on-created-empty:$TERMINAL -e btop"
      "special:audiomixer, on-created-empty:$TERMINAL -e pulsemixer"
      "special:scratchpad, on-created-empty:$TERMINAL"
      "special:networkmanager, on-created-empty:$TERMINAL -e nmtui"
    ];
  };
}
