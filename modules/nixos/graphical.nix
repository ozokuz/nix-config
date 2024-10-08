{
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    custom.themes.sddm-sober
    libsForQt5.polkit-kde-agent
  ];

  security.pam.services.swaylock = {};
  security.pam.services.sddm.enableGnomeKeyring = true;

  services = {
    xserver.enable = true;

    displayManager.sddm = {
      enable = true;
      enableHidpi = true;
      theme = "sober";
    };

    flatpak.enable = true;
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
    ];
  };

  fonts = {
    enableDefaultPackages = false;
    fontDir.enable = true;

    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      custom.fonts.monocraft

      (nerdfonts.override {
        fonts = [
          "FiraCode"
        ];
      })
    ];

    fontconfig.defaultFonts = {
      serif = ["Noto Serif" "Noto Color Emoji"];
      sansSerif = ["Noto Sans" "Noto Color Emoji"];
      monospace = ["FiraCode Nerd Font" "Noto Color Emoji"];
      emoji = ["Noto Color Emoji"];
    };
  };

  programs.hyprland = {
    enable = true;
    package = pkgs.unstable.hyprland;
    xwayland.enable = true;
  };

  programs.dconf.enable = true;
  services.gnome.gnome-keyring.enable = true;
  programs.seahorse.enable = true;
}
