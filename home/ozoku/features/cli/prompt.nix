{lib, ...}: {
  programs.starship = {
    enable = true;
    settings = {
      add_newline = true;
      format = lib.concatStrings [
        "[](color_indigo)"
        "$username"
        "[@](bold bg:color_indigo fg:color_fg0)"
        "$hostname"
        "[](fg:color_indigo bg:color_bg0)"
        "$git_branch"
        "$git_status"
        "[](fg:color_bg0 bg:color_purple)"
        "$directory"
        "[ ](bg:color_purple)[](color_purple) "
      ];

      palette = "ozoku";

      palettes.ozoku = {
        color_bg0 = "#303040";
        color_fg0 = "#c0caf5";
        color_fg1 = "#cad3f5";
        color_indigo = "#5c73e6";
        color_lime = "#29d916";
        color_purple = "#cc1fbd";
        color_purple2 = "b324a7";
        color_green = "#40a02b";
        color_red = "#e64553";
      };

      username = {
        show_always = true;
        format = "[$user]($style)";
        style_user = "bold bg:color_indigo fg:color_lime";
      };

      hostname = {
        ssh_only = false;
        format = "[$hostname ]($style)";
        style = "bold bg:color_indigo fg:color_purple";
      };

      git_branch = {
        format = "[ $symbol$branch ]($style)";
        style = "bold bg:color_bg0 fg:color_green";
      };

      git_status = {
        format = "[\\[$all_status$ahead_behind\\] ]($style)";
        conflicted = "?";
        ahead = "^";
        behind = "v";
        diverged = "-";
        up_to_date = "\\$";
        untracked = "U";
        stashed = "S";
        modified = "M";
        staged = "+";
        renamed = "R";
        deleted = "D";
        style = "bold bg:color_bg0 fg:color_red";
      };

      directory = {
        format = "[ $path]($style)[$read_only]($read_only_style)";
        style = "bold bg:color_purple fg:color_fg0";
        fish_style_pwd_dir_length = 1;
      };
    };
  };
}
