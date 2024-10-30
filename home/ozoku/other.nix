{pkgs, ...}: let
  shell = import ../../common/shell.nix;
in {
  imports = [
    ./core
  ];

  home.sessionVariables = shell.environment;
  home.packages = shell.packages pkgs;
}
