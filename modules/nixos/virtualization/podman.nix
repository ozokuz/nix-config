{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.ozoku.virtualization;
in {
  options.ozoku.virtualization = {
    podman = lib.mkEnableOption "Enable Podman";
  };

  config = lib.mkIf cfg.podman {
    environment.systemPackages = with pkgs; [
      podman
      podman-compose
    ];
  };
}
