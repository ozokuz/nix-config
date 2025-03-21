{...}: {
  wayland.windowManager.hyprland.settings = {
    windowrulev2 = [
      # Emote
      "noinitialfocus, class:^(emote)$"

      # Hearthstone
      "float, title:(HearthstoneOverlay)"
      "center, title:(HearthstoneOverlay)"
      "nofocus, title:(HearthstoneOverlay)"
      "noinitialfocus, title:(HearthstoneOverlay)"
      "noborder, title:(HearthstoneOverlay)"
      "opacity 0.2, title:(HearthstoneOverlay)"
      "stayfocused, title:^(Hearthstone)$"

      # Tearing
      "immediate, class:^(Golf With Your Friends.x86_64)$"
      "immediate, class:^(overwatch.exe)$"
      "immediate, class:^(Minecraft.*)$"
      "immediate, class:^(steam_app_.*)$"
      "immediate, class:^(osu!)$"
    ];
  };
}
