{
  inputs,
  outputs,
  ...
}: {
  imports =
    [
      inputs.home-manager.nixosModules.home-manager
      ./grub.nix
      ./nix.nix
      ./openssh.nix
      ./shell.nix
      ./sops.nix
    ]
    ++ outputs.nixosModules;

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.extraSpecialArgs = {
    inherit inputs outputs;
  };

  programs.nix-ld.enable = true;

  hardware.enableRedistributableFirmware = true;
}
