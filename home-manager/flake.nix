{
  description = "NPG418's home-manager configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/release-25.11";
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    my-nixvim = {
      url = "path:../nixvim";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-parts.follows = "flake-parts";
      };
    };
  };

  outputs =
    inputs@{
      self,
      flake-parts,
      ...
    }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ ];
      imports = [
        inputs.home-manager.flakeModules.home-manager
      ];
      flake = {
        homeModules.default = ./home.nix;
        homeConfigurations."nullp@nixos" = inputs.home-manager.lib.homeManagerConfiguration {
          pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
          modules = [
            self.homeModules.default
            inputs.my-nixvim.homeModules.default
          ];
        };
      };
    };
}
