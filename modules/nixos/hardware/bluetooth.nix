{
  lib,
  config,
  ...
}: let
  cfg = config.ozoku.bluetooth;
in {
  options.ozoku.bluetooth = {
    enable = lib.mkEnableOption "Enable bluetooth";
  };

  config = lib.mkIf cfg.enable {
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = false;
    };

    services.blueman.enable = true;
  };
}
