{ pkgs, inputs, ... }:
{
  packages = with pkgs; [
    (inputs.treefmt-nix.lib.mkWrapper pkgs {
      projectRootFile = "flake.nix";
      programs = {
        nixfmt.enable = true;
        yamlfmt.enable = true;
      };
    })
    yaml-language-server
  ];
  languages.nix.enable = true;
}
