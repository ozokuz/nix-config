{ lib, ... }:
let
  cfg = config.custom.bluetooth;
in {
  options.custom.bluetooth = {
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
