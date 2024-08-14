{ ... }: {
  imports = [
    ./hardware-configuration.nix

    ../../modules/nixos/base.nix
    ../../modules/nixos/filesystems.nix
    ../../modules/nixos/locale.nix

    ../../modules/nixos/shell.nix
    ../../modules/nixos/users.nix

    ../../modules/nixos/graphical.nix
    ../../modules/nixos/audio.nix

    ../../modules/nixos/services.nix
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
    grub = {
      enable = true;
      devices = ["nodev"];
      efiSupport = true;
      useOSProber = true;
    };
  };

  networking = {
    hostName = "enceladus";
    networkmanager.enable = true;
    enableIPv6 = false;
  };

  system.stateVersion = "24.05";
}
