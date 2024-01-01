{ pkgs, ... }:
{
  home.packages = with pkgs; [
    libsForQt5.polkit-kde-agent
  ];

  wayland.windowManager.hyprland.settings = {
    env = [
      # Wayland
      "XDG_CURRENT_DESKTOP, Hyprland"
      "XDG_SESSION_DESKTOP, Hyprland"
      "XDG_SESSION_TYPE, wayland"

      # NVIDIA
      "LIBVA_DRIVER_NAME, nvidia"
      "GBM_BACKEND, nvidia-drm"
      "__GLX_VENDOR_LIBRARY_NAME, nvidia"
      "WLR_NO_HARDWARE_CURSORS, 1"

      # QT
      "QT_AUTO_SCREEN_SCALE_FACTOR, 1"
      "QT_QPA_PLATFORM, wayland;xcb"
      "QT_QPA_PLATFORMTHEME, qt5ct"
      "QT_WAYLAND_DISABLE_WINDOWDECORATION, 1"

      # GTK
      "GDK_BACKEND, wayland,x11"

      # GNOME Keyring SSH
      "SSH_AUTH_SOCK, $XDG_RUNTIME_DIR/gcr/ssh"

      # Tearing
      "WLR_DRM_NO_ATOMIC, 1"

      # Other
      "XCURSOR_SIZE, 24"
    ];

    exec-once = [
      # Privilege Elevation
      "${pkgs.libsForQt5.polkit-kde-agent}/lib/polkit-kde-authentication-agent-1"

      # Wallpaper
      "hyprpaper"

      # Hardware
      "ckb-next --background"

      # Bluetooth
      "blueberry-tray"

      # Password Manager
      "bitwarden"

      # Widgets
      "eww daemon"

      # clipboard persist
      "wl-clip-persist --clipboard regular"

      # Apps
      "flatpak run com.discordapp.Discord"
      "spotify"
    ];
  };
}
