{inputs,...}: {
  additions = final: _prev: import ../pkgs {pkgs = final.pkgs; inherit inputs;};

  modifications = final: prev: {};

  nur = inputs.nur.overlays.default;
}
