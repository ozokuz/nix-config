{...}: {
  wayland.windowManager.hyprland.settings = {
    workspace = [
      # Special Workspaces
      "special:pwmanager, on-created-empty:bitwarden"
      "special:processes, on-created-empty:$TERMINAL -e btop"
      "special:audiomixer, on-created-empty:$TERMINAL -e pulsemixer"
      "special:scratchpad, on-created-empty:$TERMINAL"
      "special:networkmanager, on-created-empty:$TERMINAL -e nmtui"
    ];
  };
}
