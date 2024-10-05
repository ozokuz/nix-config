{
  pkgs,
  ...
}: let
  themes = pkgs.callPackage ../../pkgs/themes.nix {};
in {
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
      default = "saved";
      extraEntries = "GRUB_SAVEDEFAULT=true";
      theme = themes.lenovo-yoga-grub;
    };
  };

  boot.kernelPackages = pkgs.linuxPackages_latest;
  # boot.extraModprobeConfig = ''
  #   options snd-sof-intel-hda-common hda_model=alc287-yoga9-bass-spk-pin
  # '';

  zramSwap.enable = true;

  networking = {
    hostName = "titan";
    networkmanager.enable = true;
    enableIPv6 = true;
  };

  services.upower.enable = true;
  services.tlp.enable = true;

  hardware = {
    nvidia = {
      powerManagement = {
        enable = true;
        finegrained = true;
      };

      prime = {
        offload = {
          enable = true;
          enableOffloadCmd = true;
        };
        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";
      };
    };
  };

  system.stateVersion = "24.05";
}
