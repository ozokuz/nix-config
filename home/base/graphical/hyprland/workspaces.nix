{ ... }:
{
  wayland.windowManager.hyprland.settings = {
    monitor = [
      "eDP-1, 3072x1920@60, 0x0, 2"
      ", preferred, auto, 1"
    ];

    workspace = [
      # Workspace Definitions
      "1, monitor:eDP-1"
      "2, monitor:eDP-1, default:true"
      "3, monitor:eDP-1"
      "4, monitor:eDP-1"
      "5, monitor:eDP-1"
      "6, monitor:eDP-1"
      "7, monitor:eDP-1"
      "8, monitor:eDP-1"
      "9, monitor:eDP-1"
      "10, monitor:eDP-1"

      # Special Workspaces
      "special:pwmanager, on-created-empty:bitwarden"
      "special:processes, on-created-empty:$TERMINAL -e btop"
      "special:audiomixer, on-created-empty:$TERMINAL -e pulsemixer"
      "special:scratchpad, on-created-empty:$TERMINAL"
      "special:networkmanager, on-created-empty:$TERMINAL -e nmtui"
    ];
  };
}
