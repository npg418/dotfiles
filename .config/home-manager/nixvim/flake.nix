{
  description = "NPG418's nixvim configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      flake-parts,
      nixvim,
      ...
    }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; } (
      { withSystem, ... }:
      {
        systems = [
          "x86_64-linux"
          "aarch64-linux"
          "x86_64-darwin"
          "aarch64-darwin"
        ];

        imports = [
          nixvim.flakeModules.default
        ];

        nixvim.packages.enable = true;

        flake = {
          nixvimModules.default = ./default.nix;
          homeManagerModules.default = import ./wrappers/hm.nix nixvim [ self.nixvimModules.default ];
        };

        perSystem =
          { system, ... }:
          {
            nixvimConfigurations.default = nixvim.lib.evalNixvim {
              inherit system;
              modules = [
                self.nixvimModules.default
              ];
            };
          };
      }
    );
}
