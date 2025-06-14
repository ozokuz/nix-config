{ config, lib, pkgs, ... }:
let
  swayConfig = pkgs.writeText "greetd-sway-config" ''
    exec "${pkgs.custom.mygreet}/bin/mygreet; swaymsg exit"
    bindsym $mod+Shift+e exec swaynag \
      -t Warning \
      -m "What do you want to do?" \
      -b "Poweroff" "systemctl poweroff" \
      -b "Reboot" "systemctl reboot"
  '';
in {
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.sway}/bin/sway --config ${swayConfig}";
      };
    };
  };

  environment.etc."greetd/environments".text = ''
    hyprland (uwsm)
    fish
  '';
}
