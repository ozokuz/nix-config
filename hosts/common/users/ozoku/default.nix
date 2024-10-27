{config, ...}: {
  users.users.ozoku = {
    hashedPassword = "$6$Z2S2hwm5RjcEmJ1b$HH.X099RzUn7EPCSXSDyumIjDdITfjoXAJIHhYP7oJ68jET1hyQPcEc574P9G5yhqmnAWnGnNtwjZ4UnBwxzT.";
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
      "docker"
      "libvirtd"
      "audio"
      "input"
      "video"
      "storage"
    ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIN9iloUdc5cvzURayOT4rBhsAh/5fBTrVfv7sVMtG8i6 ozoku@cosmos"
    ];
  };

  home-manager.users.ozoku = import ../../home/ozoku/${config.networking.hostName}.nix;
}
