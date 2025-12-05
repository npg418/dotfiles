{
  description = "NPG418's nixvim configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/release-25.11";
    systems.url = "github:nix-systems/default";
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim/nixos-25.11";
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
      ];
      nixvim = {
        packages.enable = true;
        checks.enable = true;
      };
      flake = {
        nixvimModules.default = ./neovim.nix;
        homeModules = {
          nixvim = {
            imports = [ inputs.nixvim.homeModules.nixvim ];
            programs.nixvim = {
              enable = true;
              defaultEditor = true;
              vimdiffAlias = true;
              imports = [
                self.nixvimModules.default
              ];
            };
          };
          default = self.homeModules.nixvim;
        };
      };
      perSystem =
        { system, ... }:
        {
          nixvimConfigurations.default = inputs.nixvim.lib.evalNixvim {
            inherit system;
            modules = [
              self.nixvimModules.default
            ];
          };
        };
    };
}
