{ pkgs, pkgs-unstable, ...}: {
  environment.systemPackages = with pkgs; [
    podman-compose
    docker
    docker-compose
    docker-buildx
    pkgs-unstable.quickemu
    pkgs-unstable.quickgui
  ];

  # Virtualization
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;
  virtualisation.vmware.host.enable = true;

  # Containers
  virtualisation.podman.enable = true;
  virtualisation.docker.enable = true;
  virtualisation.docker.storageDriver = "btrfs";
}
