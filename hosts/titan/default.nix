{ config, pkgs, ... } @ args:
{
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos/shell.nix
    ../../modules/nixos/desktop.nix
    ../../modules/nixos/users.nix
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
  boot.kernelPackages = pkgs.linuxPackages_latest;

  zramSwap.enable = true;

  networking = {
    hostName = "titan";
    networkmanager.enable = true;
    enableIPv6 = true;
  };

  services.xserver.videoDrivers = ["nvidia"];
  services.upower.enable = true;
  services.tlp.enable = true;
  services.tailscale.enable = true;

  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = false;
    };

    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };

    nvidia = {
      modesetting.enable = true;
      powerManagement = {
        enable = true;
        finegrained = true;
      };
      open = false;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;

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

  system.stateVersion = "23.11";
}
