{ pkgs, ... }:
{
  home.username = "nullp";
  home.homeDirectory = "/home/nullp";

  programs.home-manager.enable = true;

  imports = [
    ./programs
    ./custom-home-manager.nix
  ];

  nix = {
    package = pkgs.nix;
    settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
  };
}
