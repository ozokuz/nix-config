{ pkgs, ... }:
{
  home.packages = with pkgs; [
    nodejs_20
    bun
    deno
    go
    opam
    rustup
  ];
}
