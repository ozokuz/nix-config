{ username, ... }:
{
  nix.settings.trusted-users = [username];

  users.groups = {
    "${username}" = {};
    docker = {};
  };

  users.users."${username}" = {
    hashedPassword = "$6$Z2S2hwm5RjcEmJ1b$HH.X099RzUn7EPCSXSDyumIjDdITfjoXAJIHhYP7oJ68jET1hyQPcEc574P9G5yhqmnAWnGnNtwjZ4UnBwxzT.";
    home = "/home/${username}";
    isNormalUser = true;
    description = username;
    extraGroups = [
      username
      "users"
      "networkmanager"
      "wheel"
      "docker"
      "audio"
      "input"
      "video"
    ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIN9iloUdc5cvzURayOT4rBhsAh/5fBTrVfv7sVMtG8i6 ozoku@cosmos"
    ];
  };
}
