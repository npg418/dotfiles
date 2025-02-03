{ config, lib, ... }:

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
        // lib.optionalAttrs config.programs.neovim.enable { v = "nvim"; }
        // lib.optionalAttrs config.programs.eza.enable {
          ls = "eza";
          ll = "eza -hlg";
          la = "eza -hlga";
        }
        // lib.optionalAttrs config.programs.lazygit.enable { lg = "lazygit"; }
        // lib.optionalAttrs config.programs.git.enable { cdg = "cd $(git rev-parse --show-toplevel)"; };
    };
    envExtra = ''
      if [ -e ~/.nix-profile/etc/profile.d/nix.sh ]; then
        . ~/.nix-profile/etc/profile.d/nix.sh
      fi
    '';
  };
}
