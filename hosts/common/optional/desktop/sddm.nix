{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    custom.themes.sddm-sober
  ];

  services.displayManager.sddm = {
    enable = true;
    enableHidpi = true;
    theme = "sober";
  };
}
