{ username, pkgs, ... }:
{
  imports = [];

  home = {
    username = username;
    homeDirectory = "/home/${username}";

    packages = with pkgs; [
      neofetch
      brave
      discord
      spotify
    ];

    stateVersion = "23.11";
  };

  programs.home-manager.enable = true;
}
