{
  description = "NPG418's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { nixos-wsl, ... }:
    {
      nixosModules = {
        default = ./configuration.nix;
        wsl.imports = [
          nixos-wsl.nixosModules.default
          ./wsl.nix
        ];
      };
    };
}
