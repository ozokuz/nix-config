{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.ozoku.desktop;
in {
  imports = [
    ./secrets.nix
  ];

  options.ozoku.desktop.display-manager = lib.mkEnableOption "Enable Display Manager";

  config = lib.mkIf cfg.display-manager {
    environment.systemPackages = with pkgs; [
      custom.themes.sddm-sober
    ];

    security.pam.services.sddm.enableGnomeKeyring = cfg.secrets;

    services.displayManager.sddm = {
      enable = true;
      enableHidpi = true;
      theme = "sober";
    };
  };
}
