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
      home-module = import ./home/base/graphical.nix;
    };

    # Titan - On the Go System - Laptop
    titan_modules = {
      nixos-modules = [
        ./hosts/titan
      ];
      home-module = import ./home/base/graphical.nix;
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
    };

    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager/release-23.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1&ref=refs/tags/v0.41.2";
    hyprland.inputs.nixpkgs.follows = "nixpkgs-unstable";

    split-monitor-workspaces = {
      url = "github:Duckonaut/split-monitor-workspaces";
      inputs.hyprland.follows = "hyprland";
    };
  };

  nixConfig = {
    experimental-features = ["nix-command" "flakes"];

    substituters = [
      "https://cache.nixos.org"
      "https://hyprland.cachix.org"
    ];

    extra-trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  };
}
