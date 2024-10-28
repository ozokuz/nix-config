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

    services.docker.storageDriver = lib.mkIf config.services.docker.enable "btrfs";
  };
}
