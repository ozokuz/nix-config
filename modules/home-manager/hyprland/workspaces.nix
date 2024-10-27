{
  config,
  lib,
  ...
}: let
  cfg = config.ozoku.hyprland.workspaces;
  ozoku = config.ozoku;
  utils = import ../graphics/utils.nix {inherit config lib;};
in {
  options.ozoku.hyprland.workspaces = {
    perDisplay = lib.mkOption {
      type = lib.types.bool;
      default = true;
      example = true;
      description = ''
        Whether to have per display workspaces.
      '';
    };

    moveSilently = lib.mkOption {
      type = lib.types.bool;
      default = false;
      example = true;
      description = ''
        Whether to move windows silently.
      '';
    };

    primaryModifier = lib.mkOption {
      type = lib.types.string;
      default = "";
      example = "SUPER";
      description = ''
        The primary modifier key.
        Used for all workspace related keybindings.
      '';
    };

    secondaryModifier = lib.mkOption {
      type = lib.types.string;
      default = "";
      example = "SHIFT";
      description = ''
        The secondary modifier key.
        Used for moving windows between workspaces.
      '';
    };

    special = lib.mkOption {
      type = lib.types.attrsOf (lib.types.attrs {
        exec = lib.types.string;
        keybind = lib.types.string;
      });
      default = {};
      example = {
        pwmanager = {
          exec = "$TERMINAL -e pass";
          keybind = "SUPER, S";
        };
        processes = {
          exec = "$TERMINAL -e btop";
          keybind = "SUPER, R";
        };
        audiomixer = {
          exec = "$TERMINAL -e pulsemixer";
          keybind = "SUPER, A";
        };
        scratchpad = {
          exec = "$TERMINAL";
          keybind = "SUPER, minus";
        };
        networkmanager = {
          exec = "$TERMINAL -e nmtui";
          keybind = "SUPER SHIFT, W";
        };
      };
      description = ''
        Special workspaces to configure.
      '';
    };
  };

  config = lib.mkIf ozoku.hyprland.enable {
    wayland.windowManager.hyprland = {
      plugins = [lib.mkIf cfg.perDisplay ozoku.hyprland.package.pkgs.hyprlandPlugins.hyprsplit];
      settings = {
        workspace = let
          workspaceList = lib.concatMap (display: lib.map (workspace: "${workspace}, monitor:${display.name}") display.value) utils.displayWorkspaces;
        in
          lib.mkMerge [
            (lib.mkIf cfg.perDisplay workspaceList)
            (lib.mapAttrsToList (name: value: "special:${name}, on-created-empty:${value.exec}") cfg.special)
          ];
        bind = let
          mod = cfg.primaryModifier;
          shift = cfg.secondaryModifier;
          workspaceCmd =
            if cfg.perDisplay
            then "split:workspace"
            else "workspace";
          silently =
            if cfg.moveSilently
            then "silent"
            else "";
          movetoworkspaceCmd =
            if cfg.perDisplay
            then "split:movetoworkspace${silently}"
            else "movetoworkspace${silently}";
          switchBinds = lib.map (workspaceNumber: "${mod}, ${workspaceNumber}, ${workspaceCmd}, ${workspaceNumber}") (lib.range 1 ozoku.workspaces);
          moveBinds = lib.map (workspaceNumber: "${mod} ${shift}, ${workspaceNumber}, ${movetoworkspaceCmd}, ${workspaceNumber}") (lib.range 1 ozoku.workspaces);
          specialBinds = lib.mapAttrsToList (name: value: "${value.keybind}, togglespecialworkspace, ${name}") cfg.special;
        in
          switchBinds ++ moveBinds ++ specialBinds;
      };
    };
  };
}
