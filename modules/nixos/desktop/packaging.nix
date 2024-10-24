{ lib, config, ... }:
let
  cfg = config.ozoku.modules.desktop;
in {
  options.ozoku.modules.desktop.packaging = lib.mkEnableOption "Enable Packaging";

  config = lib.mkIf cfg.packaging {
    services.flatpak.enable = true;
  };
}
