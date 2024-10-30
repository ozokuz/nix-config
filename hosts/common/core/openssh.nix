{...}: {
  services.openssh = {
    enable = true;
    settings = {
      # Hardening
      PermitRootLogin = "no";
      # TODO: Change to false when keys are set up
      PasswordAuthentication = true;
      # Not needed
      X11Forwarding = false;
    };
  };
}
