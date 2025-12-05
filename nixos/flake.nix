{
  description = "NPG418's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/release-25.05";
    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      nixos-wsl,
    }:
    {
      nixosModules = {
        default = ./configuration.nix;
        wsl.imports = [
          nixos-wsl.nixosModules.default
          ./wsl.nix
        ];
      };
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          self.nixosModules.default
          self.nixosModules.wsl
        ];
      };
    };
}
