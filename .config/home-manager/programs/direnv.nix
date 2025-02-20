{ ... }:
{
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
  programs.gint.ignores = [ ".direnv/" ];
  programs.zsh.zsh-abbr.abbreviations = {
    direnvinit = "nix flake new -t github:nix-community/nix-direnv .";
  };
}
