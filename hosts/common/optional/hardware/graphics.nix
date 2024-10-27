{pkgs, ...}: {
  hardware.opengl = {
    package = pkgs.unstable.mesa.drivers;
    package32 = pkgs.unstable.pkgsi686Linux.mesa.drivers;

    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };
}
