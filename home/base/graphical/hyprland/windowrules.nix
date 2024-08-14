{...}: {
  wayland.windowManager.hyprland.settings = {
    windowrulev2 = [
      "workspace 8 silent,class:(discord)"
      "workspace 9 silent,class:(Spotify)"

      # XWaylandVideoBridge
      "opacity 0.0 override 0.0 override,class:^(xwaylandvideobridge)$"
      "noanim,class:^(xwaylandvideobridge)$"
      "nofocus,class:^(xwaylandvideobridge)$"
      "noinitialfocus,class:^(xwaylandvideobridge)$"

      # Don't Focus Emoji Picker
      "noinitialfocus, class:^(emote)$"

      # Tearing
      "immediate, class:^(Golf With Your Friends.x86_64)$"
      "immediate, class:^(overwatch.exe)$"
      "immediate, class:^(Minecraft.*)$"
      "immediate, class:^(steam_app_.*)$"
      "immediate, class:^(osu!)$"
    ];
  };
}
