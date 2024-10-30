{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.ozoku.emote;
in {
  options.ozoku.emote.enable = lib.mkEnableOption "Enable emote";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      emote
    ];

    systemd.user.services.emote = {
      Unit = {
        Description = "Emote emoji picker";
        After = ["graphical-session.target"];
        PartOf = ["graphical-session.target"];
      };

      Service = {
        Type = "simple";
        ExecStart = "${pkgs.emote}/bin/emote";
        Restart = "always";
      };

      Install = {WantedBy = ["graphical-session.target"];};
    };
  };
}
