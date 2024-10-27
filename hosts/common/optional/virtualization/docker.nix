{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    docker
    docker-compose
    docker-buildx
  ];

  services.docker.enable = true;
}
