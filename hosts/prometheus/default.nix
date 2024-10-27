{username, ...}: {
  imports = [
    ../common/global

    ../common/users/ozoku

    ../common/optional/locale/finnish.nix
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
