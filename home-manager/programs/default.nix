{ pkgs, ... }:
{
  imports = [
    ./zsh.nix
    ./eza.nix
    ./gh.nix
    ./git.nix
    ./starship.nix
    ./lazygit.nix
    ./direnv.nix
    ./bat.nix
  ];

  programs = {
    zoxide.enable = true;
    pay-respects.enable = true;
    nix-index.enable = true;
    fzf.enable = true;
  };

  home.packages = with pkgs; [
    ripgrep
    neofetch
    zip
    unzip
    dnsutils
    cowsay
    ghq
    clang
  ];
}
