{
  description = "NixOS configuration of NPG418";
  outputs =
    { ... }:
    {
      nixosModules = {
        default = ./configuration.nix;
        wsl = ./wsl.nix;
      };
    };
}
