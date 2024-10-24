{ lib, config, ... }:
let
  cfg = config.ozoku.virtualization;
in {
  options.ozoku.virtualization = {
    vmware = lib.mkEnableOption "Enable VMware";
  };

  config = lib.mkIf cfg.vmware {
    virtualisation.vmware.host.enable = true;
  };
}