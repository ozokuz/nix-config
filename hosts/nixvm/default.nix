{config, ...} @ args:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos/core.nix
    ../../modules/nixos/users.nix
  ];

  boot.supportedFilesystems = [
    "ext4"
    "btrfs"
    "xfs"
    "ntfs"
    "fat"
    "vfat"
    "exfat"
  ];

  boot.loader = {
    efi.canTouchEfiVariables = true;
    systemd-boot.enable = true;
  };

  networking = {
    hostName = "nixvm";
    networkmanager.enable = true;
    enableIPv6 = false;
  };

  system.stateVersion = "23.11";
}
