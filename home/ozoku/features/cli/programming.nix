{pkgs, ...}: {
  home.packages = with pkgs.unstable; [
    nodejs_22
    bun
    deno
    pkgs.go
    rustup
    poetry
    python312
    elixir_1_17
    dotnet-sdk_8
    # msbuild
    temurin-bin
    kotlin
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
    nixd
    alejandra
    # lua-language-server
    # clang-tools_17
    # marksman
    # stylua
    (buildFHSUserEnv {
      name = "opam-env";
      targetPkgs = pkgs: with pkgs; [
        opam
        bubblewrap
        gcc
        gnumake
      ];
      runScript = "${pkgs.fish}/bin/fish";
    })
  ];
}
