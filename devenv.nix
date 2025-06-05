{ pkgs, inputs, ... }:
{
  packages = [
    (inputs.treefmt-nix.lib.mkWrapper pkgs {
      projectRootFile = "flake.nix";
      programs = {
        nixfmt.enable = true;
        yamlfmt.enable = true;
      };
    })
  ];
}
