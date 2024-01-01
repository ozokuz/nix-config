{
  description = "Ozoku's Nix Config";

  outputs = {
    self,
    nixpkgs,
    nixpkgs-unstable,
    home-manager,
    ...
  } @ inputs: let
    username = "ozoku";
    x64_linux = "x86_64-linux";
    systems = [x64_linux];
    forAllSystems = nixpkgs.lib.genAttrs systems;

    nixosSystem = import ./lib/nixosSystem.nix;

    saturn_modules = {
      nixos-modules = [
        ./hosts/saturn
      ];
      home-module = import ./home;
    };

    nixvm_modules = {
      nixos-modules = [
        ./hosts/nixvm
      ];
      home-module = import ./home;
    };

    x64_specialArgs =
      {
        inherit username;
        pkgs-unstable = import nixpkgs-unstable {
          system = x64_linux;
          config.allowUnfree = true;
        };
      } // inputs;
  in {
    nixosConfigurations = let
      base_args = {
        inherit home-manager;
        nixpkgs = nixpkgs;
        system = x64_linux;
        specialArgs = x64_specialArgs;
      };
    in {
      saturn = nixosSystem (saturn_modules // base_args);
      nixvm = nixosSystem (nixvm_modules // base_args);
    };

    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager/release-23.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    hyprsome.url = "github:sopa0/hyprsome";
    hyprsome.inputs.nixpkgs.follows = "nixpkgs";
  };

  nixConfig = {
    experimental-features = ["nix-command" "flakes"];

    substituters = [
      "https://cache.nixos.org"
    ];
  };
}
