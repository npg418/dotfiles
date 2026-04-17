{
  description = "Project flake for <project_name>";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    systems.url = "github:nix-systems/default";
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    my-nixvim = {
      url = "github:npg418/dotfiles";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        nixvim.follows = "nixvim";
        flake-parts.follows = "flake-parts";
      };
    };
  };

  outputs =
    inputs@{ self, flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = import inputs.systems;
      imports = [
        inputs.nixvim.flakeModules.default
      ];
      nixvim = {
        packages.enable = true;
        checks.enable = true;
      };
      flake.nixvimModules.default = { };
      perSystem =
        {
          self',
          pkgs,
          system,
          ...
        }:
        {
          nixvimConfigurations.default = inputs.nixvim.lib.evalNixvim {
            inherit system;
            modules = [
              inputs.my-nixvim.nixvimModules.default
              self.nixvimModules.default
            ];
          };
          devShells.default = pkgs.mkShellNoCC {
            packages = [
              self'.packages.default
            ];
          };
        };
    };
}
