{lib, ...}: {
  programs.starship = {
    enable = true;
    settings = {
      add_newline = true;
      format = lib.concatStrings [
        "$username"
        "$hostname"
        "$git_branch"
        "$git_status"
        "$directory"
      ];

      username = {
        show_always = true;
        format = "[](#5c73e6)[$user ]($style)";
        style_user = "bold bg:#5c73e6 #29d916";
      };

      hostname = {
        ssh_only = false;
        format = "[@](bold bg:#5c73e6 #cad3f5)[ $hostname ]($style)[](#5c73e6 bg:#24283B)";
        style = "bold bg:#5c73e6 #cc1fbd";
      };

      git_branch = {
        format = "[ $symbol$branch ]($style)";
        style = "bold bg:#24283B #40a02b";
      };

      git_status = {
        format = "[\\[$all_status$ahead_behind\\] ]($style)";
        conflicted = "C";
        ahead = "^";
        behind = "v";
        diverged = "-";
        up_to_date = " ";
        untracked = "U";
        stashed = "S";
        modified = "M";
        staged = "+";
        renamed = ">";
        deleted = "x";
        style = "bold bg:#24283B #e64553";
      };

      directory = {
        format = "[](#24283B bg:#b324a7)[ $path]($style)[$read_only]($read_only_style)[ ](bg:#b324a7)[](#b324a7) ";
        style = "bold bg:#b324a7";
        fish_style_pwd_dir_length = 1;
      };
    };
  };
}
