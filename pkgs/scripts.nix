{ stdenv, pkgs, writeShellApplication }:
{
  ode-toggle-widget = writeShellApplication {
    name = "ode_toggle_widget";
    runtimeInputs = with pkgs; [hyprland eww jq];
    text = builtins.readFile ./scripts/ode_toggle_widget.sh;
  };

  ode-lock = writeShellApplication {
    name = "ode_lock";
    runtimeInputs = with pkgs; [swaylock-effects];
    text = builtins.readFile ./scripts/ode_lock.sh;
  };

  ode-awake-status = writeShellApplication {
    name = "ode_awake_status";
    runtimeInputs = with pkgs; [systemd];
    text = builtins.readFile ./scripts/ode_awake_status.sh;
  };

  ode-awake-toggle = writeShellApplication {
    name = "ode_awake_toggle";
    runtimeInputs = with pkgs; [systemd procps];
    text = builtins.readFile ./scripts/ode_awake_toggle.sh;
  };

  ode-weather-status = writeShellApplication {
    name = "ode_weather_status";
    runtimeInputs = with pkgs; [coreutils curl gnused];
    text = builtins.readFile ./scripts/ode_weather_status.sh;
  };

  scrsht = writeShellApplication {
    name = "scrsht";
    runtimeInputs = with pkgs; [xdg-user-dirs slurp hyprland jq grim libnotify wl-clipboard curl gawk coreutils];
    text = builtins.readFile ./scripts/scrsht.sh;
  };
}
