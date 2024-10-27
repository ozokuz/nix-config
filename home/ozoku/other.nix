{pkgs, ...}: let
  shell = import ../../common/shell.nix;
in {
  imports = [
    ./global
  ];

  home.sessionVariables = shell.environment;
  home.packages = shell.packages pkgs;
}
