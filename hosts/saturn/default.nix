{pkgs, inputs, ...}: {
  imports = [
    ./hardware-configuration.nix

    ../common/core

    ../common/users/ozoku

    ../common/optional/desktop

    ../common/optional/hardware/bluetooth.nix
    ../common/optional/hardware/nvidia.nix

    ../common/optional/locale/finnish.nix

    ../common/optional/virtualization/docker.nix
    ../common/optional/virtualization/libvirt.nix
    ../common/optional/virtualization/podman.nix
    # ../common/optional/virtualization/quickemu.nix
    # ../common/optional/virtualization/vmware.nix

    ../common/optional/btrfs.nix

    ../common/optional/gaming.nix

    inputs.hardware.nixosModules.common-cpu-amd
    inputs.hardware.nixosModules.common-cpu-amd-pstate
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
  };

  boot.kernelPackages = pkgs.linuxPackages_latest;

  zramSwap.enable = true;

  networking = {
    hostName = "saturn";
    networkmanager.enable = true;
  };

  hardware = {
    nvidia.powerManagement.enable = false;

    ckb-next.enable = true;
  };

  system.stateVersion = "24.05";
}
