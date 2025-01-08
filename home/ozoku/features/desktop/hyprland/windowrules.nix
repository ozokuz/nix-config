{...}: {
  wayland.windowManager.hyprland.settings = {
    windowrulev2 = [
      # Emote
      "noinitialfocus, class:^(emote)$"

      # Hearthstone
      "float, class:(hearthstone deck tracker.exe)"
      "center, class:(hearthstone deck tracker.exe)"
      "nofocus, class:(hearthstone deck tracker.exe)"
      "noinitialfocus, class:(hearthstone deck tracker.exe)"
      "noborder, class:(hearthstone deck tracker.exe)"
      "pin, class:(hearthstone deck tracker.exe)"
      "opacity 0.2 0.1, class:(hearthstone deck tracker.exe)"
      "stayfocused, class:(hearthstone.exe)"

      # Tearing
      "immediate, class:^(Golf With Your Friends.x86_64)$"
      "immediate, class:^(overwatch.exe)$"
      "immediate, class:^(Minecraft.*)$"
      "immediate, class:^(steam_app_.*)$"
      "immediate, class:^(osu!)$"
    ];
  };
}
