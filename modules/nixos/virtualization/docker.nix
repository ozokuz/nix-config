{ pkgs, lib, config, ... }:
let
  cfg = config.ozoku.virtualization;
in {
  imports = [
    ./common.nix
  ];

  options.ozoku.virtualization = {
    docker = lib.mkEnableOption "Enable Docker";
  };

  config = lib.mkIf cfg.docker {
    environment.systemPackages = with pkgs; [
      docker
      docker-compose
      docker-buildx
    ];

    services.docker.enable = true;
    services.docker.storageDriver = if cfg.btrfsSubvolumes then "btrfs" else "overlay2";
  };
}