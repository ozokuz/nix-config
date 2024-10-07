{username, ...}: {
  imports = [
    ./base.nix
    ./environment.nix
    ./shell/fish.nix
    ./shell/prompt.nix
    ./shell/apps.nix
    ./shell/programming.nix
    ./shell/git.nix
  ];
}
