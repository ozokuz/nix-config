{pkgs, inputs, ...}: {
  imports = [
    ./theming.nix
  ];

  ozoku.defaults = {
    browser.binary = "zen";
    browser.package = inputs.zen-browser.packages.${pkgs.system}.default;
    terminal.binary = "ghostty";
    terminal.package = inputs.ghostty.packages.${pkgs.system}.default;
  };

  home.packages = with pkgs; [
    brave
    firefox
    floorp
    spotify
    bitwarden
    pulsemixer
    nvtopPackages.full
    nsxiv
    #ciscoPacketTracer8
    nautilus
    sushi
    discord
    nautilus-open-any-terminal
    obsidian
    podman-desktop
    distrobox
    vscode-fhs
    jetbrains-toolbox
    gitkraken
    vesktop
    code-cursor
  ];

  programs.alacritty = {
    enable = true;
    package = pkgs.alacritty;
    settings = {
      window.opacity = 0.9;
      font = {
        normal.family = "FiraCode Nerd Font";
        size = 11;
      };
      cursor.style = {
        shape = "Block";
        blinking = "On";
      };
      mouse.hide_when_typing = true;
      hints.enabled = [
        {
          regex = "(mailto:|https:|http:|file:|git:|ssh:|ftp:)[^\\u0000-\\u001F\\u007F-\\u009F<>\"\\\\s{-}\\\\^⟨⟩`]+";
          command = "xdg-open";
          post_processing = true;
          mouse.enabled = true;
        }
      ];
    };
  };

  programs.kitty = {
    enable = true;
    package = pkgs.kitty;
    themeFile = "tokyo_night_storm";
    font = {
      name = "FiraCode Nerd Font";
      size = 11;
    };
    shellIntegration = {
      mode = "enabled";
      enableFishIntegration = true;
    };
    extraConfig = ''
      background_opacity 0.9
    '';
  };

  programs.mpv.enable = true;
  programs.zathura.enable = true;

  xdg.userDirs = {
    enable = true;
    createDirectories = true;
  };

  xdg.mime.enable = true;
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      # Directory
      "inode/directory" = ["org.gnome.Nautilus.desktop"];
      # Text file
      "text/plain" = ["nvim.desktop"];
      # PDF
      "application/pdf" = ["org.pwmt.zathura.desktop"];
      # Applications
      "x-scheme-handler/jetbrains" = ["JetBrains Toolbox.desktop"];

      # Web Browser
      "x-scheme-handler/http" = ["zen.desktop"];
      "x-scheme-handler/https" = ["zen.desktop"];
      "x-scheme-handler/chrome" = ["zen.desktop"];
      "text/html" = ["zen.desktop"];
      "application/x-extension-htm" = ["zen.desktop"];
      "application/x-extension-html" = ["zen.desktop"];
      "application/x-extension-shtml" = ["zen.desktop"];
      "application/xhtml+xml" = ["zen.desktop"];
      "application/x-extension-xhtml" = ["zen.desktop"];
      "application/x-extension-xht" = ["zen.desktop"];
    };
  };
}
