{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.ozoku.gaming;
in {
  options.ozoku.gaming = {
    enable = lib.mkEnableOption "Enable gaming";
  };

  config = lib.mkIf cfg.enable {
    programs.steam.enable = true;

    environment.systemPackages = with pkgs; [
      (lutris.override {
        extraPkgs = pkgs: [
          pkgs.wineWowPackages.stagingFull
        ];
      })
    ];
  };
}
