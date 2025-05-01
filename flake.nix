{
  description = "NPG418's dotfiles with nix!";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } (
      { config, ... }:
      {
        systems = [
          "x86_64-linux"
          "aarch64-linux"
        ];
        imports = [
          inputs.home-manager.flakeModules.home-manager
          inputs.nixvim.flakeModules.default
        ];
        nixvim.packages.enable = true;
        flake = {
          nixosModules = {
            default = ./nixos/configuration.nix;
            wsl.imports = [
              inputs.nixos-wsl.nixosModules.default
              ./nixos/wsl.nix
            ];
          };
          homeModules = {
            npg418 = ./home-manager/home.nix;
            nixvim = import ./nixvim/home-manager/wrapper.nix inputs.nixvim [
              config.flake.nixvimModules.default
            ];
            default.imports = [
              config.flake.homeModules.npg418
              config.flake.homeModules.nixvim
            ];
          };
          nixvimModules.default = ./nixvim;
        };
        perSystem =
          { system, pkgs, ... }:
          {
            devShells.default = pkgs.mkShellNoCC {
              packages = with pkgs; [
                treefmt
                nixfmt-rfc-style
                taplo
              ];
            };
            nixvimConfigurations.default = inputs.nixvim.lib.evalNixvim {
              inherit system;
              modules = [
                config.flake.nixvimModules.default
              ];
            };
          };
      }
    );
}
