{
  description = "NPG418's dotfiles with nix!";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/release-25.11";
    flake-parts.url = "github:hercules-ci/flake-parts";
    systems.url = "github:nix-systems/default";
    nixvim = {
      url = "github:nix-community/nixvim/nixos-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    my-nixvim = {
      url = "path:./nixvim";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        nixvim.follows = "nixvim";
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
      systems = import inputs.systems;
      imports = [
        inputs.nixvim.flakeModules.default
      ];
      nixvim = {
        packages.enable = true;
        checks.enable = true;
      };
      flake = {
        templates = {
          project-flake = {
            path = ./templates/project-flake;
            description = "Project root configuration flake";
          };
          default = self.templates.project-flake;
        };
        nixvimModules.default = {
          lsp.servers = {
            nil_ls.enable = true;
          };
          plugins = {
            conform-nvim.settings = {
              formatters_by_ft = {
                nix = [ "nixfmt" ];
              };
            };
          };
        };
      };
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
