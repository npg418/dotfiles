{ pkgs, ... }:
{
  home.username = "nullp";
  home.homeDirectory = "/home/nullp";

  home.stateVersion = "24.05";

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
