{ lib, config, ... }:
let
  cfg = config.ozoku.desktop;
in {
  options.ozoku.desktop.packaging = lib.mkEnableOption "Enable Packaging";

  config = lib.mkIf cfg.packaging {
    services.flatpak.enable = true;
  };
}
