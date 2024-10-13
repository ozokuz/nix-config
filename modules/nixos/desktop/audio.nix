{ pkgs, lib, ... }:
let
  cfg = config.custom.audio;
in {
  options.custom.audio = {
    enable = lib.mkEnableOption "Enable audio";
  };

  config = lib.mkIf cfg.enable {
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
