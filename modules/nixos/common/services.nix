{ username, ...}: {
  programs.kdeconnect.enable = true;

  services = {
    udisks2.enable = true;
    tailscale.enable = true;
    syncthing = {
      enable = true;
      systemService = false;
      user = username;
      group = username;
      dataDir = "/home/${username}";
      openDefaultPorts = true;
    };
  };
}
