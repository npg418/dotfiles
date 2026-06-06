{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/release-25.11";
    dotfiles = {
      url = "github:npg418/dotfiles?dir=nixos";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      dotfiles,
    }:
    {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          dotfiles.nixosModules.default
          dotfiles.nixosModules.wsl
          ./configuration.nix
        ];
      };
    };
}
