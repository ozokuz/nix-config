{ lib, config, ... }:
let
  cfg = config.custom.virtualization;
in {
  options.custom.virtualization = {
    vmware = lib.mkEnableOption "Enable VMware";
  };

  config = lib.mkIf cfg.vmware {
    virtualisation.vmware.host.enable = true;
  };
}