{
  description = "NPG418's nixvim configuration";

  inputs = {
    systems.url = "github:nix-systems/default";
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixvim.url = "github:nix-community/nixvim/nixos-26.05";
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
              imports = [ self.nixvimModules.default ];
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
