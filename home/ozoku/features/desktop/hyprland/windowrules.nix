{...}: {
  wayland.windowManager.hyprland.settings = {
    windowrulev2 = [
      # Tearing
      "immediate, class:^(Golf With Your Friends.x86_64)$"
      "immediate, class:^(overwatch.exe)$"
      "immediate, class:^(Minecraft.*)$"
      "immediate, class:^(steam_app_.*)$"
      "immediate, class:^(osu!)$"
    ];
  };
}
