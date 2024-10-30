{
  imports = [
    ./core
    ./features/desktop/hyprland
  ];

  ozoku.displays = [
    {
      port = "DP-2";
      resolution = "2560x1440@144";
      position = "2560x0";
      scale = 1;
    }
    {
      port = "DP-3";
      resolution = "2560x1440@60";
      position = "0x0";
      scale = 1;
    }
  ];

  wayland.windowManager.hyprland.settings = {
    cursor.no_hardware_cursors = true;

    env = [
      "GBM_BACKEND, nvidia-drm"
      "__GLX_VENDOR_LIBRARY_NAME, nvidia"
      "LIBVA_DRIVER_NAME, nvidia"
    ];

    windowrulev2 = [
      "workspace 11 silent,class:(discord)"
      "workspace 20 silent,class:(Spotify)"
    ];
  };
}
