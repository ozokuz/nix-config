{pkgs, ...}: {
  security.pam.services.hyprlock = {};

  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };

  services.gvfs = {
    enable = true;
    package = pkgs.gvfs.override {
      gnomeSupport = true;
    };
  };
}
