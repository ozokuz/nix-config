{config, ...}: {
  security.pam.services.sddm.enableGnomeKeyring = config.services.displayManager.sddm.enable;
  services.gnome.gnome-keyring.enable = true;
  programs.seahorse.enable = true;
}
