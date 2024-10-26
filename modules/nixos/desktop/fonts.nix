{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.ozoku.desktop;
in {
  options.ozoku.desktop.fonts = lib.mkEnableOption "Enable Fonts";

  config = lib.mkIf cfg.fonts {
    fonts = {
      enableDefaultPackages = false;
      fontDir.enable = true;

      packages = with pkgs; [
        noto-fonts
        noto-fonts-cjk
        noto-fonts-emoji
        custom.fonts.monocraft

        (nerdfonts.override {
          fonts = [
            "FiraCode"
            "JetBrainsMono"
          ];
        })
      ];

      fontconfig.defaultFonts = {
        serif = ["Noto Serif" "Noto Color Emoji"];
        sansSerif = ["Noto Sans" "Noto Color Emoji"];
        monospace = ["FiraCode Nerd Font" "Noto Color Emoji"];
        emoji = ["Noto Color Emoji"];
      };
    };
  };
}
