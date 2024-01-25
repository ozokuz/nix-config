{ ... }:
{
  wayland.windowManager.hyprland.settings = {
    monitor = [
      "eDP-1, 3072x1920@60, 0x0, 2"
      ", preferred, auto, 1"
    ];

    workspace = [
      # Workspace Definitions
      "1, monitor:eDP-1, persistent:true"
      "2, monitor:eDP-1, persistent:true, default:true"
      "3, monitor:eDP-1, persistent:true"
      "4, monitor:eDP-1, persistent:true"
      "5, monitor:eDP-1, persistent:true"
      "6, monitor:eDP-1, persistent:true"
      "7, monitor:eDP-1, persistent:true"
      "8, monitor:eDP-1, persistent:true"
      "9, monitor:eDP-1, persistent:true"
      "10, monitor:eDP-1, persistent:true"

      # Special Workspaces
      "special:2fa, on-created-empty:authy"
      "special:processes, on-created-empty:$TERMINAL -e btop"
      "special:audiomixer, on-created-empty:$TERMINAL -e pulsemixer"
      "special:scratchpad, on-created-empty:$TERMINAL"
      "special:networkmanager, on-created-empty:$TERMINAL -e nmtui"
    ];
  };
}
