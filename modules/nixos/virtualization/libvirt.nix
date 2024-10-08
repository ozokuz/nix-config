{ pkgs, lib, config, ... }:
let
  cfg = config.custom.virtualization;
in {
  imports = [
    ./common.nix
  ];

  options.custom.virtualization = {
    libvirt = lib.mkEnableOption "Enable Libvirt";
  };

  config = lib.mkIf cfg.libvirt {
    virtualisation.libvirtd.enable = true;
    programs.virt-manager.enable = cfg.guiTools;
  };
}