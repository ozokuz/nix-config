{...}: {
  wayland.windowManager.hyprland.settings = {
    windowrulev2 = [
      # XWaylandVideoBridge
      "opacity 0.0 override 0.0 override,class:^(xwaylandvideobridge)$"
      "noanim,class:^(xwaylandvideobridge)$"
      "nofocus,class:^(xwaylandvideobridge)$"
      "noinitialfocus,class:^(xwaylandvideobridge)$"

      # Don't Focus Emoji Picker

      # Tearing
      "immediate, class:^(Golf With Your Friends.x86_64)$"
      "immediate, class:^(overwatch.exe)$"
      "immediate, class:^(Minecraft.*)$"
      "immediate, class:^(steam_app_.*)$"
      "immediate, class:^(osu!)$"
    ];
  };
}
