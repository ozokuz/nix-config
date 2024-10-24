{ pkgs, lib, config, ... }:
let
  cfg = config.ozoku.virtualization;
in {
  imports = [
    ./common.nix
  ];

  options.ozoku.virtualization = {
    libvirt = lib.mkEnableOption "Enable Libvirt";
  };

  config = lib.mkIf cfg.libvirt {
    virtualisation.libvirtd.enable = true;
    programs.virt-manager.enable = cfg.guiTools;
  };
}