{ ... }: {
  wayland.windowManager.hyprland.settings = {
    env = [
      "GBM_BACKEND, nvidia-drm"
      "__GLX_VENDOR_LIBRARY_NAME, nvidia"
      "LIBVA_DRIVER_NAME, nvidia"
    ];
  };
}