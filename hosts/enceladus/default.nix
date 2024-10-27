{...}: {
  imports = [
    ./hardware-configuration.nix

    ../common/global

    ../common/users/ozoku

    ../common/optional/desktop

    ../common/optional/locale/finnish.nix

    ../common/optional/btrfs.nix
  ];

  fileSystems = {
    "/".options = ["discard=async" "compress=zstd"];
    "/home".options = ["discard=async" "compress=zstd"];
    "/nix".options = ["discard=async" "compress=zstd" "noatime"];
  };

  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot/efi";
    };
  };

  networking = {
    hostName = "enceladus";
    networkmanager.enable = true;
    enableIPv6 = false;
  };

  system.stateVersion = "24.05";
}
