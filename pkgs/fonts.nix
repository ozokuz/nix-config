{
  stdenv,
  fetchurl,
  pkgs,
  fetchFromGitHub,
}: {
  monocraft = let
    version = "3.0";
    relArtifact = name: hash:
      fetchurl {
        inherit name hash;
        url = "https://github.com/IdreesInc/Monocraft/releases/download/v${version}/${name}";
      };
  in
    stdenv.mkDerivation {
      pname = "monocraft";
      inherit version;

      srcs = [
        (relArtifact "Monocraft.otf" "sha256-PA1W+gOUStGw7cDmtEbG+B6M+sAYr8cft+Ckxj5LciU=")
        (relArtifact "Monocraft.ttf" "sha256-S4j5v2bTJbhujT3Bt8daNN1YGYYP8zVPf9XXjuR64+o=")
        (relArtifact "Monocraft-no-ligatures.ttf" "sha256-MuHfoP+dsXe+ODN4vWFIj50jwOxYyIiS0dd1tzVxHts=")
        (relArtifact "Monocraft-nerd-fonts-patched.ttf" "sha256-QxMp8UwcRjWySNHWoNeX2sX9teZ4+tCFj+DG41azsXw=")
      ];

      sourceRoot = ".";
      unpackCmd = ''cp "$curSrc" $(basename $curSrc)'';

      dontConfigure = true;
      dontBuild = true;

      installPhase = ''
        runHook preInstall
        install -Dm644 -t $out/share/fonts/opentype *.otf
        install -Dm644 -t $out/share/fonts/truetype *.ttf
        runHook postInstall
      '';
    };
}
