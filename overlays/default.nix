{inputs,...}: {
  additions = final: _prev: import ../pkgs final.pkgs;

  modifications = final: prev: {};

  nur = inputs.nur.overlays.default;
}
