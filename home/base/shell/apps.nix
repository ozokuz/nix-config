{pkgs, ...}: {
  home.packages = with pkgs; [
    neofetch
  ];

  programs.command-not-found.enable = false;

  programs.bat.enable = true;
  programs.btop.enable = true;
  programs.direnv.enable = true;
  programs.zoxide.enable = true;
  programs.tmux.enable = true;
  programs.zellij.enable = true;
  programs.fzf.enable = true;
  programs.jq.enable = true;

  programs.eza = {
    enable = true;
    extraOptions = ["--group-directories-first"];
    icons = true;
    git = true;
  };
}
