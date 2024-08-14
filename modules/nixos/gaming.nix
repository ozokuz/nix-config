{ pkgs, ... }: {
  programs.steam.enable = true;

  environment.systemPackages = with pkgs; [
    (lutris.override {
      extraPkgs = pkgs: [
        pkgs.wineWowPackages.stagingFull
      ];
    })
  ];
}