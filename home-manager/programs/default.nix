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
    ./bat.nix
    ./nixvim.nix
  ];

  programs = {
    zoxide.enable = true;
    pay-respects.enable = true;
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
