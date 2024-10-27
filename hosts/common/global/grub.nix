{
  boot.loader = {
    grub = {
      enable = true;
      devices = ["nodev"];
      efiSupport = true;
      useOSProber = true;
      default = "saved";
      extraEntries = "GRUB_SAVEDEFAULT=true";
    };
  };
}
