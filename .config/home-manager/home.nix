{ pkgs, ... }:

{

  home.username = "nullp";
  home.homeDirectory = "/home/nullp";

  home.stateVersion = "24.05";

  programs.home-manager.enable = true;

  imports = [
    ./programs/neovim
    ./programs/zsh.nix
    ./programs/starship.nix
    ./programs/git.nix
    ./programs/gh.nix
    ./programs/eza.nix
  ];

  home.packages = with pkgs; [
    ripgrep
    neofetch
    zip
    unzip
    dnsutils
    cowsay
    lazygit
  ];

  programs.zoxide.enable = true;
  programs.thefuck.enable = true;

  nix.package = pkgs.nix;
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
}
