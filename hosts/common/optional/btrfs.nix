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

    services.docker.storageDriver = lib.mkfIf config.services.docker.enable "btrfs";
  };
}
