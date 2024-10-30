{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.ozoku.emote;
in {
  options.ozoku.emote = {
    enable = lib.mkEnableOption "Enable emote";

    systemd.enable = lib.mkEnableOption "Enable the systemd service";
  };

  config = lib.mkIf cfg.enable (lib.mkMerge [
    {
      home.packages = with pkgs; [
        emote
      ];
    }
    (lib.mkIf
      cfg.systemd.enable
      {
        systemd.user.services.emote = lib.mkIf cfg.systemd.enable {
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
      })
  ]);
}
