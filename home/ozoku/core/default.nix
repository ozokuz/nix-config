{
  outputs,
  config,
  ...
}: {
  imports =
    [
      ../features/cli
    ]
    ++ (builtins.attrValues outputs.homeManagerModules);

  home = {
    username = "ozoku";
    homeDirectory = "/home/${config.home.username}";
    stateVersion = "24.05";
    sessionPath = ["$HOME/.local/bin"];
  };

  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
    warn-dirty = false;
  };

  ozoku.home.cleaner-home.enable = true;

  systemd.user.startServices = "sd-switch";

  programs.home-manager.enable = true;
}
