{
  pkgs,
  pkgs-unstable,
  ...
}: {
  home.packages = with pkgs; [
    brave
    firefox
    floorp
    spotify
    bitwarden
    pulsemixer
    nvtopPackages.full
    nsxiv
    gnome.nautilus
    gnome.sushi
    discord
    nautilus-open-any-terminal
    obsidian
    podman-desktop
    distrobox
    pkgs-unstable.vscode-fhs
    pkgs-unstable.jetbrains-toolbox
    pkgs-unstable.gitkraken
    pkgs-unstable.vesktop
  ];

  programs.alacritty = {
    enable = true;
    package = pkgs-unstable.alacritty;
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
    package = pkgs-unstable.kitty;
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
}
