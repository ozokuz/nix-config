{ config, ... } @ args:
{
  # TODO: Complete configuration

  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos/shell.nix
    ../../modules/nixos/desktop.nix
    ../../modules/nixos/users.nix
  ];

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
    hostName = "titan";
    networkmanager.enable = true;
    enableIPv6 = true;
  };

  services.xserver.videoDrivers = ["nvidia"];

  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
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
        intelBusId = "";
        nvidiaBusId = "";
      };
    };
  };

  system.stateVersion = "23.11";
}
