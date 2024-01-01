{ username, ... }:
{
  imports = [
    ./environment.nix
    ./desktop/hyprland
    ./desktop/apps.nix
    ./shell/fish.nix
    ./shell/prompt.nix
    ./shell/apps.nix
  ];

  home = {
    username = username;
    homeDirectory = "/home/${username}";

    stateVersion = "23.11";
  };

  programs.home-manager.enable = true;
}
