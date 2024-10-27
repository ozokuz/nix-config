{pkgs, ...}: {
  environment.shells = with pkgs; [
    bash
    fish
    nushell
  ];

  programs.fish.enable = true;

  users.defaultUserShell = pkgs.fish;

  environment.systemPackages = with pkgs; [
    unstable.neovim
    curl
    wget
    tree
    git
    ripgrep
    fd
    gcc
    gnumake
    unzip
    zip
    psmisc
    lshw
    file
    nh
    nvd
    nix-output-monitor
  ];

  environment.sessionVariables = {
    FLAKE = "/home/ozoku/.local/src/nix-config";
  };
  environment.variables.EDITOR = "nvim";
}
