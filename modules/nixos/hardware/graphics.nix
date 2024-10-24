{ lib, config, ... }:
let
  cfg = config.ozoku.hardware.graphics;
in {
  options.ozoku.hardware.graphics = {
    enable = lib.mkEnableOption "Enable Graphics";
  };

  config = lib.mkIf cfg.enable {
    hardware.opengl = {
      package = pkgs-unstable.mesa.drivers;
      package32 = pkgs-unstable.pkgsi686Linux.mesa.drivers;

      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };
  };
}