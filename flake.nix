{
  description = "NPG418's dotfiles with nix!";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/release-25.11";
    flake-parts.url = "github:hercules-ci/flake-parts";
    systems.url = "github:nix-systems/default";
    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim/nixos-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    treefmt = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
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

        homeModules.default.imports = [
          { nixpkgs.overlays = [ inputs.rust-overlay.overlays.default ]; }
          ./home-manager/home.nix
          (import ./nixvim/home-manager/wrapper.nix inputs.nixvim [
            self.nixvimModules.default
          ])
        ];

        nixvimModules.default = ./nixvim;

        templates.projectFlake = {
          path = ./templates/project-flake;
          description = "Project root configuration flake";
        };
      };

      nixvim.checks.enable = false;

      perSystem =
        { pkgs, system, ... }:
        {
          treefmt = {
            projectRootFile = "flake.nix";
            programs.nixfmt.enable = true;
          };

          devShells.default = pkgs.mkShellNoCC {
            packages = [ self.formatter.${system} ];
          };
        };
    };
}
