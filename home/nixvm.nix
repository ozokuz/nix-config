{ username, ... }:
{
  imports = [];

  home = {
    username = username;
    homeDirectory = "/home/${username}";

    stateVersion = "23.11";
  };

  programs.home-manager.enable = true;
}
