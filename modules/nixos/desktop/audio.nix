{ pkgs, lib, config, ... }:
let
  cfg = config.ozoku.desktop;
in {
  options.ozoku.desktop.audio = lib.mkEnableOption "Enable audio";

  config = lib.mkIf cfg.audio {
    environment.systemPackages = with pkgs; [
      alsa-utils
      tree
    ];

    security.rtkit.enable = true;

    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
      wireplumber.enable = true;
    };
  };
}
