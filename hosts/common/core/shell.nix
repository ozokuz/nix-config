{pkgs, ...}: let
  shell = import ../../../common/shell.nix;
in {
  environment.shells = with pkgs; [
    bash
    fish
    nushell
  ];

  programs.fish.enable = true;

  documentation.man.generateCaches = pkgs.lib.mkForce false;

  users.defaultUserShell = pkgs.fish;

  environment.systemPackages = shell.packages pkgs;
  environment.sessionVariables = shell.environment;
}
