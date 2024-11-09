{inputs, pkgs, ...}: {
  imports = [inputs.ags.homeManagerModules.default];

  programs.ags = {
    enable = true;
    configDir = ./config;
    extraPackages = with pkgs; [
      custom.scripts.ode-weather-status
    ];
  };
}
