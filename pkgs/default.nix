pkgs: {
  custom = {
    scripts = pkgs.callPackage ./scripts.nix {};
    fonts = pkgs.callPackage ./fonts.nix {};
    themes = pkgs.callPackage ./themes.nix {};
  };
}
