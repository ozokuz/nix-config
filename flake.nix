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

    # Saturn - Main System - Desktop
    saturn_modules = {
      nixos-modules = [
        ./hosts/saturn
      ];
      home-module = import ./home/graphical.nix;
    };

    # Titan - On the Go System - Laptop
    titan_modules = {
      nixos-modules = [
        ./hosts/titan
      ];
      home-module = import ./home/graphical.nix;
    };

    # Enceladus - Testing System - Virtual Machine
    enceladus_modules = {
      nixos-modules = [
        ./hosts/enceladus
      ];
      home-module = import ./home/shell.nix;
    };

    # Prometheus - Secondary Linux Environment - WSL
    prometheus_modules = {
      nixos-modules = [
        ./hosts/prometheus
      ];
      home-module = import ./home/shell.nix;
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
      titan = nixosSystem (titan_modules // base_args);
      enceladus = nixosSystem (enceladus_modules // base_args);
      prometheus = nixosSystem (prometheus_modules // base_args);
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
