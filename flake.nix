{
  description = "NPG418's dotfiles with nix!";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/release-25.05";
    flake-parts.url = "github:hercules-ci/flake-parts";
    systems.url = "github:nix-systems/default";
    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim/nixos-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    treefmt = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      self,
      flake-parts,
      ...
    }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = import inputs.systems;
      imports = [
        inputs.nixvim.flakeModules.default
        inputs.treefmt.flakeModule
      ];
      flake = {
        nixosModules = {
          default = ./nixos/configuration.nix;
          wsl.imports = [
            inputs.nixos-wsl.nixosModules.default
            ./nixos/wsl.nix
          ];
        };
        homeModules = {
          base = ./home-manager/home.nix;
          nixvim = import ./nixvim/home-manager/wrapper.nix inputs.nixvim [
            self.nixvimModules.default
          ];
          default.imports = [
            self.homeModules.base
            self.homeModules.nixvim
          ];
        };
        nixvimModules.default = ./nixvim;
      };
      nixvim.checks.enable = false;
      perSystem =
        { ... }:
        {
          treefmt = {
            projectRootFile = "flake.nix";
            programs = {
              alejandra.enable = true;
              nixfmt.enable = true;
            };
          };
        };
    };
}
