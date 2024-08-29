{ ...  }: {
  programs.waybar.settings = {
    mainBar = {
      "hyprland/workspaces" = {
        format = "{icon}";
        format-icons = {
          "11" = "1";
          "12" = "2";
          "13" = "3";
          "14" = "4";
          "15" = "5";
          "16" = "6";
          "17" = "7";
          "18" = "8";
          "19" = "9";
        };
        persistent-workspaces = {
          DP-2 = [1 2 3 4 5 6 7 8 9 10];
          DP-3 = [11 12 13 14 15 16 17 18 19 20];
        };
      };
    };
  };
}
