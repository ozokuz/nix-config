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
    python312
    lua-language-server
    clang-tools_17
    marksman
    stylua
    elixir_1_16
    ruby_3_3
    # nixd
    # nil
    dotnet-sdk_7
  ];

  xdg.configFile."npm/npmrc".source = ./npmrc;
}
