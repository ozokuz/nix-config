{
  stdenv,
  fetchurl,
  pkgs,
  fetchFromGitHub,
}: let
  qtge = pkgs.libsForQt5.qt5.qtgraphicaleffects;
in {
  sddm-sober = stdenv.mkDerivation {
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
      echo "" >> $out/share/sddm/themes/sober/theme.conf.user
      echo "menu.default.size=full" >> $out/share/sddm/themes/sober/theme.conf.user
      echo "enable.button.fullscreen.switch=false" >> $out/share/sddm/themes/sober/theme.conf.user
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

  lenovo-yoga-grub = stdenv.mkDerivation {
    pname = "lenovo-yoga-grub-theme";
    version = "1.0";

    dontBuild = true;

    installPhase = ''
      runHook preInstall

      mkdir -p $out/

      cp -r $src/yoga/* $out/

      runHook postInstall
    '';

    src = fetchFromGitHub {
      owner = "mBilG";
      repo = "lenovo-yoga-grub-theme";
      rev = "be268036ffe3d68e58c745f588ee2dee2365e25a";
      hash = "sha256-j+BmvkbkeGUs7l+aF8MPlMF1KP7oqewQ4HQw20arULI=";
    };
  };

  kvlibadwaita = stdenv.mkDerivation {
    pname = "kvlibadwaita";
    version = "1.0";

    dontBuild = true;

    installPhase = ''
      runHook preInstall

      mkdir -p $out/share/Kvantum

      cp -r $src/src/KvLibadwaita $out/share/Kvantum/

      runHook postInstall
    '';

    src = fetchFromGitHub {
      owner = "GabePoel";
      repo = "KvLibadwaita";
      rev = "87c1ef9f44ec48855fd09ddab041007277e30e37";
      hash = "sha256-xBl6zmpqTAH5MIT5iNAdW6kdOcB5MY0Dtrb95hdYpwA=";
    };
  };
}
