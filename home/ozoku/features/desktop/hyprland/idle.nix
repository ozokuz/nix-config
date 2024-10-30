{pkgs, ...}: {
  services.hypridle.enable = true;
  services.hypridle.settings = {
    general = {
      lock_cmd = "pidof hyprlock || hyprlock --immediate";
      before_sleep_cmd = "${pkgs.playerctl}/bin/playerctl pause && loginctl lock-session";
      after_sleep_cmd = "${pkgs.brightnessctl}/bin/brightnessctl -r";
    };
    listener = [
      {
        timeout = 300;
        on-timeout = "${pkgs.brightnessctl}/bin/brightnessctl -s set 5%";
        on-resume = "${pkgs.brightnessctl}/bin/brightnessctl -r";
      }
      {
        timeout = 600;
        on-timeout = "hyprlock";
      }
      {
        timeout = 660;
        on-timeout = "${pkgs.systemd}/bin/systemctl suspend";
      }
    ];
  };
}
