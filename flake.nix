{
  description = "Ozoku's Nix Config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    systems.url = "github:nix-systems/default";
    systems-linux.url = "github:nix-systems/default-linux";
    systems-darwin.url = "github:nix-systems/default-darwin";

    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    nixpkgs,
    systems,
    home-manager,
    ...
  } @ inputs: let
    inherit (self) outputs;

    username = "ozoku";

    # Saturn - Main System - Desktop
    saturn_modules = {
      nixos-modules = [
        ./hosts/saturn
      ];
      home-module = import ./home/saturn;
    };

    # Titan - On the Go System - Laptop
    titan_modules = {
      nixos-modules = [
        ./hosts/titan
      ];
      home-module = import ./home/titan;
    };

    pkgsFor = nixpkgs.lib.genAttrs (import systems) (system: import nixpkgs {inherit system; config.allowUnfree = true;});
    forEachSystem = f: nixpkgs.lib.genAttrs (import systems) (system: f pkgsFor.${system});

    specialArgs = {
      inherit inputs outputs username;
    };

    nixosSystem = {
      nixos-modules,
      home-module,
      system ? "x86_64-linux",
    }: nixpkgs.lib.nixosSystem {
      inherit system specialArgs;

      modules = nixos-modules ++ [
        home-manager.nixosModules.home-manager
        impermanence.nixosModules.default
        stylix.nixosModule
        sops-nix.nixosModule
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = specialArgs;
          home-manager.users."${username}" = home-module;
        }
      ];
    };
  in {
    packages = forEachSystem (pkgs: import ./pkgs pkgs);
    overlays = import ./overlays {inherit inputs;};
    nixosModules = import ./modules/nixos;
    homeManagerModules = import ./modules/home-manager;

    nixosConfigurations = {
      saturn = nixosSystem saturn_modules;
      titan = nixosSystem titan_modules;
    };

    homeConfigurations = {};

    formatter = forEachSystem (pkgs: pkgs.alejandra);
  };
}
