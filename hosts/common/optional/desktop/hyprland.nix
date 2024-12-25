{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    libsForQt5.polkit-kde-agent
  ];

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
