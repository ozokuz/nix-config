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
    ozoku.graphics.enable = true;

    wayland.windowManager.hyprland = {
      enable = true;
      package = pkgs.unstable.hyprland;
      systemd = {
        enable = true;
        variables = ["--all"];
      };
      settings.monitor = lib.map (d: "${d.port}, ${d.resolution}, ${d.position}, ${toString d.scale}") cfg.displays;
    };
  };
}
