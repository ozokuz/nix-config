{ stdenv, pkgs, writeShellApplication }:
{
  ode-toggle-widget = writeShellApplication {
    name = "ode_toggle_widget";
    runtimeInputs = with pkgs; [hyprland eww-wayland jq];
    text = builtins.readFile ./scripts/ode_toggle_widget.sh;
  };

  scrsht = writeShellApplication {
    name = "scrsht";
    runtimeInputs = with pkgs; [xdg-user-dirs slurp hyprland jq grim libnotify wl-clipboard curl gawk coreutils];
    text = builtins.readFile ./scripts/scrsht.sh;
  };
}
