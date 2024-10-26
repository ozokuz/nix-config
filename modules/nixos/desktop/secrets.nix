{
  lib,
  config,
  ...
}: let
  cfg = config.ozoku.desktop;
in {
  options.ozoku.desktop.secrets = lib.mkEnableOption "Enable Secrets";

  config = lib.mkIf cfg.secrets {
    services.gnome.gnome-keyring.enable = true;
    programs.seahorse.enable = true;
  };
}
