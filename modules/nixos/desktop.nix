{ config, lib, pkgs, pkgs-unstable, ... }:
{
  environment.shells = with pkgs; [
    bash
    fish
    nushell
  ];

  programs.fish.enable = true;

  users.defaultUserShell = pkgs.fish;

  environment.systemPackages = with pkgs; [
    psmisc
    mako
    libsForQt5.polkit-kde-agent
    gnome.gnome-keyring
    gnome.seahorse
    waybar
    eww-wayland
    hyprpaper
    tofi
    gammastep
    blueberry
    playerctl
    kitty
  ];

  security.rtkit.enable = true;

  hardware = {
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };

    nvidia = {
      modesetting.enable = true;
      powerManagement.enable = false;
      open = false;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };

    ckb-next.enable = true;
  };

  services = {
    xserver = {
      enable = true;
      videoDrivers = ["nvidia"];
      displayManager.sddm.enable = true;
    };

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
      wireplumber.enable = true;
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
}
