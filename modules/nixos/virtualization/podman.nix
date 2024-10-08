{ pkgs, lib, config, ... }:
let
  cfg = config.custom.virtualization;
in {
  options.custom.virtualization = {
    podman = lib.mkEnableOption "Enable Podman";
  };

  config = lib.mkIf cfg.podman {
    environment.systemPackages = with pkgs; [
      podman
      podman-compose
    ];
  };
}