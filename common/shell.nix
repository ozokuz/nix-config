{
  packages = pkgs:
    with pkgs; [
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

  environment = {
    EDITOR = "nvim";
    FLAKE = "/home/ozoku/.local/src/nix-config";
  };
}
