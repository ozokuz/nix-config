{ lib, config, ... }:
let
  cfg = config.ozoku.desktop.secrets;
in {
  options.ozoku.desktop.secrets = lib.mkEnableOption "Enable Secrets";

  config = lib.mkIf cfg.enable {
    services.gnome.gnome-keyring.enable = true;
    programs.seahorse.enable = true;
  };
}
