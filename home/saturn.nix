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
      pulsemixer
    ];

    stateVersion = "23.11";
  };

  programs.home-manager.enable = true;
}
