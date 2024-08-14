{ username, ... }: {
  imports = [
    ../../modules/nixos/base.nix
    ../../modules/nixos/locale.nix

    ../../modules/nixos/shell.nix
    ../../modules/nixos/users.nix
  ];

  wsl = {
    enable = true;
    useWindowsDriver = true;
    defaultUser = username;
    startMenuLaunchers = false;
    docker-desktop.enable = true;
  };

  networking.hostName = "prometheus";

  system.stateVersion = "24.05";
}
