{ lib, ... }:
let
  cfg = config.custom.filesystems;
in {
  options.custom.filesystems.maintenance = {
    enable = lib.mkEnableOption "Enable filesystem maintenance";
  };

  config = lib.mkIf cfg.maintenance.enable {
    services.fstrim.enable = true;
    services.btrfs.autoScrub = {
      enable = true;
      interval = "monthly";
      fileSystems = ["/"];
    };
  };
}
