{
  pkgs,
  pkgs-unstable,
  ...
}: {
  environment.shells = with pkgs; [
    bash
    fish
    nushell
  ];

  programs.fish.enable = true;

  users.defaultUserShell = pkgs.fish;

  environment.systemPackages = with pkgs; [
    pkgs-unstable.neovim
    curl
    wget
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
  ];

  environment.variables.EDITOR = "nvim";
}
