{ ... }: {
  services = {
    xserver.enable = true;
  };

  programs.dconf.enable = true;
}
