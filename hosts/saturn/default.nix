{ pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix

    ../../modules/nixos/base.nix
    ../../modules/nixos/filesystems.nix
    ../../modules/nixos/locale.nix

    ../../modules/nixos/shell.nix
    ../../modules/nixos/users.nix

    ../../modules/nixos/graphical.nix
    ../../modules/nixos/audio.nix
    ../../modules/nixos/nvidia.nix
    ../../modules/nixos/bluetooth.nix

    ../../modules/nixos/services.nix
    ../../modules/nixos/gaming.nix
    ../../modules/nixos/virtualization.nix
  ];

  fileSystems = {
    "/".options = ["discard=async" "compress=zstd"];
    "/home".options = ["discard=async" "compress=zstd"];
    "/nix".options = ["discard=async" "compress=zstd" "noatime"];
    "/files".options = ["uid=1000" "dmask=0022" "fmask=0113" "nofail"];
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

  boot.kernelPackages = pkgs.linuxPackages_6_8;

  zramSwap.enable = true;

  networking = {
    hostName = "saturn";
    networkmanager.enable = true;
    enableIPv6 = false;
  };

  hardware = {
    nvidia.powerManagement.enable = false;

    ckb-next.enable = true;
  };

  system.stateVersion = "24.05";
}
