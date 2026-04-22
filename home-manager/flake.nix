{
  description = "NPG418's home-manager configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
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
        inputs.home-manager.flakeModules.default
      ];
      flake.homeModules = {
        base = ./home.nix;
        nixvim.imports = [
          inputs.my-nixvim.homeModules.default
          ./programs/nixvim.nix
        ];
        default.imports = [
          self.homeModules.base
          self.homeModules.nixvim
        ];
      };
    };
}
