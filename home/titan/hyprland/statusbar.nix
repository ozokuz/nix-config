{ ...  }: {
  programs.waybar.settings = {
    mainBar = {
      "hyprland/workspaces" = {
        persistent-workspaces = {
          eDP-1 = [1 2 3 4 5 6 7 8 9 10];
        };
      };
    };
  };
}
