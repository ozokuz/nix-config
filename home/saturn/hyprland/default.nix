{ ... }: {
  imports = [
    ./environment.nix
    ./statusbar.nix
    ./windowrules.nix
    ./workspaces.nix
  ];

  wayland.windowManager.hyprland.settings = {
    cursor.no_hardware_cursors = true;
  };
}