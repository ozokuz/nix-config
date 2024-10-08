{ ... }:
{
  imports = [
    ./common.nix
    ./docker.nix
    ./podman.nix
    ./libvirt.nix
    ./vmware.nix
    ./quickemu.nix
  ];
}