{
  pkgs,
  lib,
  config,
  ...
}: {
  services = {
    xserver.enable = true;
    flatpak.enable = true;
  };

  programs.dconf.enable = true;
}
