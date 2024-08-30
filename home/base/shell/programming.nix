{ pkgs, pkgs-unstable, ... }: {
  home.packages = with pkgs-unstable; [
    nodejs_22
    bun
    deno
    pkgs.go
    opam
    rustup
    poetry
    python312
    elixir_1_17
    dotnet-sdk_8
    ruby_3_3
    swift
    swiftPackages.swiftpm
    gleam
    nim
    nimble
    nim-atlas
    odin
    haxe
    zig
    ghc
    crystal
    dart
    # lua-language-server
    # clang-tools_17
    # marksman
    # stylua
  ];

  xdg.configFile."npm/npmrc".source = ./npmrc;
}
