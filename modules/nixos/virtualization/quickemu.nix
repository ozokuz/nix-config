{ pkgs, lib, config, ... }:
let
  cfg = config.ozoku.virtualization;
in {
  imports = [
    ./common.nix
  ];

  options.ozoku.virtualization = {
    quickemu = lib.mkEnableOption "Enable QuickEmu";
  };

  config = lib.mkIf cfg.quickemu {
    environment.systemPackages = with pkgs; [
      quickemu
    ] ++ (if cfg.guiTools then [ quickgui ] else []);
  };
}