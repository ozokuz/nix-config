{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    libsForQt5.polkit-kde-agent
  ];

  security.pam.services.hyprlock = {};

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
    ];
  };

  programs.hyprland = {
    enable = true;
    package = pkgs.unstable.hyprland;
    xwayland.enable = true;
  };

  services.gvfs = {
    enable = true;
    package = pkgs.unstable.gvfs;
  };
}
