{
  lib,
  config,
  ...
}: {
  config = {
    wayland.windowManager.hyprland.settings = lib.mkIf (config.ozoku.hyprland.enable && config.ozoku.emote.enable) {
      windowrulev2 = [
        "noinitialfocus, class:^(emote)$"
      ];
    };
  };
}
