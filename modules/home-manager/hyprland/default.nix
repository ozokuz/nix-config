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
    package = lib.mkPackageOption pkgs "hyprland" {};
  };

  config = lib.mkIf cfg.hyprland.enable {
    ozoku.graphics.enable = true;

    wayland.windowManager.hyprland = {
      enable = true;
      package = cfg.package;
      systemd = {
        enable = true;
        variables = ["--all"];
      };
      settings.monitor = lib.map (d: "${d.port}, ${d.resolution}, ${d.position}, ${d.scale}") cfg.ozoku.displays;
    };
  };
}
