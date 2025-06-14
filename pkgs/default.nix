pkgs: {
  custom = {
    scripts = pkgs.callPackage ./scripts.nix {};
    fonts = pkgs.callPackage ./fonts.nix {};
    themes = pkgs.callPackage ./themes.nix {};
    bibata-hyprcursor = pkgs.callPackage ./bibata-hyprcursor {};
    mygreet = ags.lib.bundle {
      inherit pkgs;
      src = ../hosts/common/optional/desktop/mygreet;
      name = "mygreet";
      entry = "app.ts";

      extraPackages = with ags.packages.${system} [
        battery
        network
        greet
      ];
    };
  };
}
