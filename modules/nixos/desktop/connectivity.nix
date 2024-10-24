{ username, lib, config, ... }:
let
  cfg = config.ozoku.modules.desktop;
in {
  options.ozoku.modules.desktop.connectivity = lib.mkEnableOption "Enable Connectivity";

  config = lib.mkIf cfg.connectivity {
    programs.kdeconnect.enable = true;
    services.udisks2.enable = true;

    services = {
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
  };
}
