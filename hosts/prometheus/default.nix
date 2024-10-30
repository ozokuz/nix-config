{
  imports = [
    ../common/core

    ../common/users/ozoku

    ../common/optional/locale/finnish.nix
  ];

  wsl = {
    enable = true;
    useWindowsDriver = true;
    defaultUser = "ozoku";
    startMenuLaunchers = false;
    docker-desktop.enable = true;
  };

  networking.hostName = "prometheus";

  system.stateVersion = "24.05";
}
