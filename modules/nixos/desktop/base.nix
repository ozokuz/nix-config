{
  lib,
  config,
  ...
}: let
  cfg = config.ozoku.desktop;
in {
  options.ozoku.desktop.enable = lib.mkEnableOption "Enable Desktop";

  config = lib.mkIf cfg.enable {
    services = {
      xserver.enable = true;
    };

    programs.dconf.enable = true;
  };
}
