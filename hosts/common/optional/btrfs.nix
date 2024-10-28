{
  config,
  lib,
  ...
}: {
  config = {
    services.btrfs.autoScrub = {
      enable = true;
      interval = "monthly";
      fileSystems = ["/"];
    };

    virtualisation.docker.storageDriver = lib.mkIf config.virtualisation.docker.enable "btrfs";
  };
}
