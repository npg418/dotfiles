{ pkgs, ... }:
{
  imports = [
    # ./neovim
    ./zsh.nix
    ./direnv.nix
    ./eza.nix
    ./gh.nix
    ./git.nix
    ./nixvim.nix
    ./starship.nix
  ];

  programs = {
    zoxide.enable = true;
    thefuck.enable = true;
  };

  home.packages = with pkgs; [
    ripgrep
    neofetch
    zip
    unzip
    dnsutils
    cowsay
  ];
}
