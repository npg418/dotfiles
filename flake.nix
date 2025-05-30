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
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      flake-parts,
      systems,
      nixos-wsl,
      nixvim,
      ...
    }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = import systems;
      imports = [
        nixvim.flakeModules.default
      ];
      flake = {
        nixosModules = {
          default = ./nixos/configuration.nix;
          wsl.imports = [
            nixos-wsl.nixosModules.default
            ./nixos/wsl.nix
          ];
        };
        homeModules = {
          base = ./home-manager/home.nix;
          nixvim = import ./nixvim/home-manager/wrapper.nix nixvim [
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
        { pkgs, system, ... }:
        {
          devShells.default = pkgs.mkShellNoCC {
            packages = with pkgs; [
              treefmt
              nixfmt-rfc-style
              taplo
            ];
          };
          nixvimConfigurations.default = nixvim.lib.evalNixvim {
            inherit system;
            modules = [
              self.nixvimModules.default
            ];
          };
        };
    };
}
