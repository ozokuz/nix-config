{
  programs.kdeconnect.enable = true;
  services.udisks2.enable = true;

  services = {
    tailscale.enable = true;
    syncthing = {
      enable = true;
      systemService = false;
      user = "ozoku";
      group = "ozoku";
      dataDir = "/home/ozoku";
      openDefaultPorts = true;
    };
  };
}
