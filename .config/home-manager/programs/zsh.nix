{ config, ... }:

{
  nixpkgs.config.allowUnfree = true;
  programs.zsh = {
    enable = true;
    defaultKeymap = "emacs";
    dotDir = ".config/zsh";
    syntaxHighlighting.enable = true;
    autocd = true;
    autosuggestion.enable = true;
    zsh-abbr = {
      enable = true;
      abbreviations =
        {
          hm = "home-manager";
        }
        // (if config.programs.neovim.enable then { v = "nvim"; } else { })
        // (
          if config.programs.eza.enable then
            {
              ls = "eza";
              ll = "eza -hlg";
              la = "eza -hlga";
            }
          else
            { }
        );
    };
    envExtra = ''
      if [ -e ~/.nix-profile/etc/profile.d/nix.sh ]; then
        . ~/.nix-profile/etc/profile.d/nix.sh
      fi
    '';
  };
}
