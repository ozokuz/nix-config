{
  imports = [
    ./global
    ./features/desktop/hyprland
  ];

  ozoku.displays = [
    {
      port = "eDP-1";
      resolution = "3072x1920@60";
      position = "0x0";
      scale = 2;
    }
    {
      port = "";
      resolution = "preferred";
      position = "auto";
      scale = 1;
    }
  ];

  wayland.windowManager.hyprland.settings = {
    windowrulev2 = [
      "workspace 8 silent,class:(discord)"
      "workspace 9 silent,class:(Spotify)"
    ];
  };
}
