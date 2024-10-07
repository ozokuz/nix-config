{...}:
{
  programs.git = {
    enable = true;
    userName = "Ozoku";
    userEmail = "19756856+ozokuz@users.noreply.github.com";
    extraConfig = {
      credential.helper = "cache";
      init.defaultBranch = "main";
    };
    lfs.enable = true;
    delta.enable = true;
  };

  programs.lazygit = {
    enable = true;
    settings = {
      gui.showIcons = true;
      git.paging = {
        colorArg = "always";
        pager = "delta --dark --paging=never";
      };
      notARepository = "quit";
    };
  };

  programs.gh = {
    enable = true;
    settings = {
      git_protocol = "ssh";
      prompt = "enabled";
      pager = "bat";
      aliases = {
        co = "pr checkout";
      };
    };
  };
}
