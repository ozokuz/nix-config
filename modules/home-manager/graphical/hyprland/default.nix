{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.ozoku;
in {
  imports = [
    ./workspaces.nix
  ];

  options.ozoku.hyprland = {
    enable = lib.mkEnableOption "Ozoku's extended Hyprland configuration";
  };

  config = lib.mkIf cfg.hyprland.enable {
    ozoku.graphical.enable = true;

    wayland.windowManager.hyprland = {
      enable = true;
      package = pkgs.hyprland;
      systemd = {
        enable = true;
        variables = ["--all"];
      };
      settings.monitor = lib.map (d: "${d.port}, ${d.resolution}, ${d.position}, ${toString d.scale}") cfg.displays;
    };

    home.sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };
  };
}
