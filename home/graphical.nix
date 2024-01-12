{ username, ... }:
{
  imports = [
    ./base.nix
    ./environment.nix
    ./desktop/hyprland
    ./desktop/apps.nix
    ./shell/fish.nix
    ./shell/prompt.nix
    ./shell/apps.nix
    ./shell/programming.nix
  ];
}

