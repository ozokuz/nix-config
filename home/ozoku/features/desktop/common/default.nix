{pkgs, inputs,...}: {
  imports = [
    ./theming.nix
  ];

  home.sessionVariables = {
    # Defaults
    BROWSER = "zen";
    TERMINAL = "kitty";
  };

  home.packages = with pkgs; [
    inputs.zen-browser.packages.${system}.specific
    brave
    firefox
    floorp
    spotify
    bitwarden
    pulsemixer
    nvtopPackages.full
    nsxiv
    ciscoPacketTracer8
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
      "inode/directory" = ["org.gnome.Nautilus.desktop"];

      "text/plain" = ["nvim.desktop"];

      "x-scheme-handler/http" = ["zen.desktop"];
      "x-scheme-handler/https" = ["zen.desktop"];
      "text/html" = ["zen.desktop"];

      "application/pdf" = ["org.pwmt.zathura.desktop"];

      "x-scheme-handler/jetbrains" = ["JetBrains Toolbox.desktop"];
    };
  };
}
