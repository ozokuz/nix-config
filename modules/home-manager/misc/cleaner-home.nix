{
  config,
  pkgs,
  lib,
  ...
}: let
  vars = config.home.sessionVariables;
  cfg = config.ozoku.home;
in {
  options.ozoku.home.cleaner-home = {
    enable = lib.mkEnableOption "Enable Cleaner Home";
  };

  config = lib.mkIf cfg.cleaner-home.enable {
    home.sessionVariables = {
      # XDG
      XDG_CONFIG_HOME = "$HOME/.config";
      XDG_CACHE_HOME = "$HOME/.cache";
      XDG_DATA_HOME = "$HOME/.local/share";
      XDG_STATE_HOME = "$HOME/.local/state";

      # Cleaner Home
      GOPATH = "${vars.XDG_DATA_HOME}/go";
      CARGO_HOME = "${vars.XDG_DATA_HOME}/cargo";
      CUDA_CACHE_PATH = "${vars.XDG_CACHE_HOME}/nv";
      GNUPGHOME = "${vars.XDG_DATA_HOME}/gnupg";
      LESSHISTFILE = "${vars.XDG_CACHE_HOME}/less/history";
      NODE_REPL_HISTORY = "${vars.XDG_DATA_HOME}/node_repl_history";
      WINEPREFIX = "${vars.XDG_DATA_HOME}/wine";
      NPM_CONFIG_USERCONFIG = "${vars.XDG_CONFIG_HOME}/npm/npmrc";
      DOTNET_ROOT = "${pkgs.dotnet-sdk_8}";
    };

    home.sessionPath = [
      "${vars.CARGO_HOME}/bin"
      "${vars.GOPATH}/bin"
      "${vars.XDG_DATA_HOME}/npm/bin"
    ];

    xdg.configFile."npm/npmrc".text = ''
      cache=${vars.XDG_CACHE_HOME}/npm
      prefix=${vars.XDG_DATA_HOME}/npm
    '';
  };
}
