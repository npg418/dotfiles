{ pkgs, ... }:
{
  imports = [
    # ./neovim
    ./zsh.nix
    ./eza.nix
    ./gh.nix
    ./git.nix
    ./starship.nix
    ./lazygit.nix
    ./direnv.nix
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
    ghq
  ];
}
