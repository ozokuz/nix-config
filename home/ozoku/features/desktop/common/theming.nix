{pkgs, ...}: {
  home.pointerCursor = {
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 24;
    gtk.enable = true;
  };

  home.packages = [
    pkgs.custom.bibata-hyprcursor
  ];

  gtk = {
    enable = true;
    font = {
      name = "Noto Sans";
      size = 10;
    };
    iconTheme = {
      package = pkgs.kdePackages.breeze-icons;
      name = "breeze-dark";
    };
    theme = {
      package = pkgs.adw-gtk3;
      name = "adw-gtk3-dark";
    };
    gtk3 = {
      bookmarks = ["file:///home/ozoku/Downloads" "file:///home/ozoku/src" "file:///files/Vault" "file:/// NixOS"];
      extraConfig.gtk-application-prefer-dark-theme = true;
    };
  };

  dconf.settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";

  qt = {
    enable = true;
    platformTheme.name = "qtct";
    style.name = "kvantum";
  };

  xdg.configFile = {
    "Kvantum/KvLibadwaita".source = "${pkgs.custom.themes.kvlibadwaita}/share/Kvantum/KvLibadwaita";
    "Kvantum/kvantum.kvconfig".text = "[General]\ntheme=KvLibadwaitaDark"
  };

  home.sessionVariables = {
    HYPRCURSOR_THEME = "Bibata-modern";
    HYPRCURSOR_SIZE = "24";
  };
}
