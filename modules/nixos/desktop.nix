{ config, lib, pkgs, pkgs-unstable, ... }:
let
  sddm-themes = pkgs.callPackage ../../pkgs/sddm-themes.nix {};
in 
{
  environment.systemPackages = with pkgs; [
    sddm-themes.sddm-sober
    libsForQt5.polkit-kde-agent
    (lutris.override {
      extraPkgs = pkgs: [
        pkgs.wineWowPackages.stagingFull
      ];
    })
  ];

  security.rtkit.enable = true;
  security.pam.services.swaylock = {};
  security.pam.services.sddm.enableGnomeKeyring = true;

  services = {
    xserver = {
      enable = true;
      displayManager.sddm = {
        enable = true;
        enableHidpi = true;
        theme = "sober";
      };
    };

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
      wireplumber.enable = true;
    };

    blueman.enable = true;
    
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
    xwayland.enable = true;
  };

  programs.steam.enable = true;
  programs.kdeconnect.enable = true;

  programs.dconf.enable = true;
  services.udisks2.enable = true;
  services.gnome.gnome-keyring.enable = true;
  programs.seahorse.enable = true;
}
