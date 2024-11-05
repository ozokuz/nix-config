{pkgs, inputs,...}: {
  imports = [
    ./theming.nix
  ];

  home.sessionVariables = {
    # Defaults
    BROWSER = "flatpak run io.github.zen_browser.zen";
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
    gnome.nautilus
    gnome.sushi
    discord
    nautilus-open-any-terminal
    obsidian
    podman-desktop
    distrobox
    unstable.vscode-fhs
    unstable.jetbrains-toolbox
    unstable.gitkraken
    unstable.vesktop
  ];

  programs.alacritty = {
    enable = true;
    package = pkgs.unstable.alacritty;
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
    package = pkgs.unstable.kitty;
    theme = "Tokyo Night Storm";
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

  xdg.mimeApps = {
    enable = false;
    defaultApplications = {
      "text/plain" = ["nvim.desktop"];
      "x-scheme-handler/http" = ["firefox.desktop"];
      "x-scheme-handler/https" = ["firefox.desktop"];
      "x-scheme-handler/webcal" = ["firefox.desktop"];
      "text/html" = ["firefox.desktop"];
      "application/pdf" = ["org.pwmt.zathura.desktop"];
      "inode/directory" = ["org.gnome.Nautilus.desktop"];
      "x-scheme-handler/jetbrains" = ["JetBrains Toolbox.desktop"];
    };
  };
}
