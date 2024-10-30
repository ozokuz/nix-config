{config, ...}: {
  programs.hyprlock.enable = true;
  programs.hyprlock.settings = {
    general = {
      hide_cursor = true;
      grace = 5;
    };

    background = {
      path = "/home/${config.home.username}/.local/wallpaper.png";
      blur_passes = 1;
      blur_size = 2;
      brightness = 0.5;
    };

    input-field = {
      size = "200, 50";
      outline_thickness = 2;
      dots_size = 0.4;
      dots_spacing = 0.15;
      dots_rounding = -1;
      dots_fade_time = 200;
      outer_color = "rgb(200, 100, 200)";
      inner_color = "rgb(10, 10, 10)";
      font_color = "rgb(200, 200, 200)";
      font_family = "Noto Sans";
      fade_on_empty = true;
      fade_timeout = 200;
      placeholder_text = "";
      rounding = -1;
      check_color = "rgb(200, 200, 100)";
      fail_color = "rgb(200, 100, 100)";
      fail_text = "";
      fail_timeout = 500;
      fail_transition = 200;
      halign = "center";
      valign = "center";
    };

    label = {
      text = "$TIME";
      text_align = "center";
      color = "rgb(200, 200, 200)";
      font_size = 40;
      font_family = "Noto Sans";
      halign = "center";
      valign = "top";
      position = "0, 50";
    };
  };
}
