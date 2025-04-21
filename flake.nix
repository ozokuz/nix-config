{
  description = "Ozoku's Nix Config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    systems.url = "github:nix-systems/default";
    systems-linux.url = "github:nix-systems/default-linux";
    systems-darwin.url = "github:nix-systems/default-darwin";

    hardware.url = "github:NixOS/nixos-hardware/master";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    ags.url = "github:Aylur/ags";
    ags.inputs.nixpkgs.follows = "nixpkgs";

    zen-browser.url = "github:youwen5/zen-browser-flake";
    zen-browser.inputs.nixpkgs.follows = "nixpkgs";

    packwiz.url = "github:packwiz/packwiz";
    packwiz.inputs.nixpkgs.follows = "nixpkgs";

    vscode-server.url = "github:nix-community/nixos-vscode-server";
    vscode-server.inputs.nixpkgs.follows = "nixpkgs";

    impermanence.url = "github:nix-community/impermanence";
    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";
    stylix.url = "github:danth/stylix";
    stylix.inputs.nixpkgs.follows = "nixpkgs";

    nur.url = "github:nix-community/NUR";
    nur.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    systems,
    ...
  } @ inputs: let
    inherit (self) outputs;

    pkgsFor = nixpkgs.lib.genAttrs (import systems) (system:
      import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      });
    forEachSystem = f: nixpkgs.lib.genAttrs (import systems) (system: f pkgsFor.${system});

    specialArgs = {
      inherit inputs outputs;
    };
  in {
    packages = forEachSystem (pkgs: import ./pkgs pkgs);
    overlays = import ./overlays {inherit inputs;};
    nixosModules = import ./modules/nixos;
    homeManagerModules = import ./modules/home-manager;

    nixosConfigurations = {
      # Saturn - Main System - Desktop
      saturn = nixpkgs.lib.nixosSystem {
        inherit specialArgs;
        modules = [./hosts/saturn];
      };
      # Titan - On the Go System - Laptop
      titan = nixpkgs.lib.nixosSystem {
        inherit specialArgs;
        modules = [./hosts/titan];
      };
    };

    homeConfigurations = {
      # Home Manager on other systems
      "ozoku@other" = home-manager.lib.homeManagerConfiguration {
        modules = [./home/ozoku/other.nix];
        pkgs = pkgsFor.x86_64-linux;
        extraSpecialArgs = specialArgs;
      };
    };

    formatter = forEachSystem (pkgs: pkgs.alejandra);
  };
}
