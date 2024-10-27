{
  packages = pkgs:
    with pkgs; [
      # Base tools
      file
      curl
      wget
      tree
      psmisc
      lshw
      # File searching
      ripgrep
      fd
      # Editor
      unstable.neovim
      # Version Control
      git
      # Archive tools
      unzip
      zip
      # Compiling
      gcc
      gnumake
      # Nix tools
      nh # Nix Helper
      nvd # Nix Version Differ
      nix-output-monitor
    ];

  environment = {
    EDITOR = "nvim";
    FLAKE = "/home/ozoku/.local/src/nix-config";
  };
}
