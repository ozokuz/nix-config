{
  lib,
  config,
  ...
}: let
  cfg = config.ozoku;
  displayType = lib.types.submodule {
    options = {
      port = lib.mkOption {
        type = lib.types.str;
        default = "";
        example = "DP-1";
        description = ''
          The port to connect the display to.
        '';
      };
      resolution = lib.mkOption {
        type = lib.types.str;
        default = "preferred";
        example = "1920x1080@60";
        description = ''
          The resolution of the display.
        '';
      };
      position = lib.mkOption {
        type = lib.types.str;
        default = "auto";
        example = "0x0";
        description = ''
          The position of the display in the format "XxY".
        '';
      };
      scale = lib.mkOption {
        type = lib.types.int;
        default = 1;
        example = 1;
        description = ''
          The scale of the display.
        '';
      };
    };
  };
in {
  options.ozoku = {
    graphical.enable = lib.mkEnableOption "Enable graphical configuration.";

    displays = lib.mkOption {
      type = lib.types.nullOr (lib.types.listOf displayType);
      default = null;
      example = [
        {
          port = "eDP-1";
          resolution = "3840x2160@60";
          position = "0x0";
          scale = 2;
        }
        {
          port = "";
          resolution = "preferred";
          position = "auto";
          scale = 1;
        }
      ];
      description = ''
        List of displays to configure.
      '';
    };

    workspaces = lib.mkOption {
      type = lib.types.int;
      default = 6;
      example = 6;
      description = ''
        The number of workspaces.
        When using hyprland and using ozoku.hyprland.perDisplayWorkspaces,
        this number will be per each display.
      '';
    };
  };

  config = {
    assertions = [
      {
        assertion = cfg.graphics.enable -> !(cfg.displays == null || cfg.displays == []);
        message = "At least one display must be configured.";
      }
      {
        assertion = cfg.graphics.enable -> cfg.workspaces > 0;
        message = "The number of workspaces must be greater than 0.";
      }
      {
        assertion = cfg.graphics.enable -> cfg.workspaces <= 9;
        message = "The number of workspaces must be less than or equal to 9.";
      }
    ];
  };
}
