{ pkgs, ... }:

{

  home.username = "nullp";
  home.homeDirectory = "/home/nullp";

  home.stateVersion = "24.05";

  programs.home-manager.enable = true;

  imports = [
    # ./programs/neovim
    ./programs/nixvim.nix
    ./programs/zsh.nix
    ./programs/starship.nix
    ./programs/git.nix
    ./programs/gh.nix
    ./programs/eza.nix
    ./programs/direnv.nix
  ];

  programs.zoxide.enable = true;
  programs.thefuck.enable = true;
  programs.lazygit.enable = true;

  home.packages = with pkgs; [
    ripgrep
    neofetch
    zip
    unzip
    dnsutils
    cowsay
  ];

  nix = {
    package = pkgs.nix;
    settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
  };
}
