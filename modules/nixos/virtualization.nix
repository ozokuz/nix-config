{ pkgs, lib, config, ...}: 
let
  cfg = config.custom.virtualization;
in {
  imports = [
    ./storage.nix
    ./graphical.nix
  ];

  options.custom.virtualization = {
    docker = lib.mkEnableOption "Enable Docker";
    podman = lib.mkEnableOption "Enable Podman";
    libvirt = lib.mkEnableOption "Enable Libvirt";
    vmware = lib.mkEnableOption "Enable VMware";
    quickemu = lib.mkEnableOption "Enable QuickEmu";
    guiTools = lib.mkEnableOption "Enable GUI tools for virtualization";
  };

  config = 
    let
      docker = lib.mkIf cfg.docker {
        environment.systemPackages = with pkgs; [
          pkgs.docker
          docker-compose
          docker-buildx
        ];

        services.docker.enable = true;
        services.docker.storageDriver = if config.storage.fileSystem == "btrfs" then "btrfs" else "overlay2";
      };
      podman = lib.mkIf cfg.podman {
        environment.systemPackages = with pkgs; [
          pkgs.podman
          podman-compose
        ];

        services.podman.enable = true;
      };
      libvirt = lib.mkIf cfg.libvirt {
        virtualisation.libvirtd.enable = true;
        programs.virt-manager.enable = cfg.guiTools;
      };
      vmware = lib.mkIf cfg.vmware {
        virtualisation.vmware.host.enable = true;
      };
      quickemu = lib.mkIf cfg.quickemu {
        environment.systemPackages = [
          pkgs.quickemu
        ] ++ (if cfg.guiTools then [ pkgs.quickgui ] else []);
      };
    in lib.mkMerge [
      docker
      podman
      libvirt
      vmware
      quickemu
    ];
}
