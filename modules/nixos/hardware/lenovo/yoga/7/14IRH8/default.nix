{...}: {
  services.tlp.enable = true;

  hardware = {
    intelgpu = {
      driver = "xe";
      vaapiDriver = "intel-media-driver";
    };

    nvidia = {
      powerManagement = {
        enable = true;
        finegrained = true;
      };

      prime = {
        offload = {
          enable = true;
          enableOffloadCmd = true;
        };

        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";
      };
    };
  };
}
