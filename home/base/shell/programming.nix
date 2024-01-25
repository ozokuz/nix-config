{ pkgs, ... }:
{
  home.packages = with pkgs; [
    nodejs_20
    bun
    deno
    go
    opam
    rustup
    poetry
    python3
    lua-language-server
    nixd
    nil
  ];

  xdg.configFile."npm/npmrc".source = ./npmrc;
}
