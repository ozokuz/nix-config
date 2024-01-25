{ stdenv, fetchurl, pkgs }:
let
  qtge = pkgs.libsForQt5.qt5.qtgraphicaleffects;
in 
{
  sddm-sober = stdenv.mkDerivation rec {
    pname = "sddm-sober-theme";
    version = "1.0";
    dontBuild = true;
    propagatedBuildInputs = [
      qtge
    ];
    dontWrapQtApps = true;
    installPhase = ''
      mkdir -p $out/share/sddm/themes/sober
      tar xf $src -C $out/share/sddm/themes
    '';
    postFixup = ''
      mkdir -p $out/nix-support

      echo ${qtge} >> $out/nix-support/propagated-user-env-packages
    '';
    src = fetchurl {
      url = "https://github.com/Rokin05/sddm-themes/raw/master/releases/sddm-sober.tar.gz";
      hash = "sha256-sswb3fLhxq88YOKO+xdu2p6Fe+m5ZaOES0pm/MR7UxI=";
    };
  };
}
