{
  pkgs,
  outputs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix

    ../common/global

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

    outputs.nixosModules.lenovo-yoga-pro-7-14irh8
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

    grub.theme = pkgs.custom.themes.lenovo-yoga-grub;
  };

  boot.kernelPackages = pkgs.linuxPackages_latest;
  # boot.extraModprobeConfig = ''
  #   options snd-sof-intel-hda-common hda_model=alc287-yoga9-bass-spk-pin
  # '';

  zramSwap.enable = true;

  networking = {
    hostName = "titan";
    networkmanager.enable = true;
  };

  services.upower.enable = true;

  system.stateVersion = "24.05";
}
