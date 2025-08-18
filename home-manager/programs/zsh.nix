{
  lib,
  config,
  pkgs,
  ...
}:
let
  hasFzf = config.programs.fzf.enable;
  hasGhq = builtins.elem pkgs.ghq config.home.packages;
in
{
  nixpkgs.config.allowUnfree = true;
  programs.zsh = {
    enable = true;
    defaultKeymap = "emacs";
    dotDir = ".config/zsh";
    syntaxHighlighting.enable = true;
    autocd = true;
    autosuggestion = {
      enable = true;
      strategy = [
        "history"
        "completion"
      ];
    };
    history = {
      ignoreAllDups = true;
      ignoreSpace = true;
    };
    zsh-abbr = {
      enable = true;
      abbreviations.hm = "home-manager";
    };
    initContent = lib.mkIf (hasFzf && hasGhq) ''
      function ghq_fzf_change_directory() {
        local src=$(ghq list | fzf --preview "eza -l -g -a --icons $(ghq root)/{} | tail -n+4 | awk '{print \$6\"/\"\$8\" \"\$9 \" \" \$10}'")
        if [ -n "$src" ]; then
          BUFFER="cd $(ghq root)/$src"
          zle accept-line
        fi
        zle -R -c
      }
      zle -N ghq_fzf_change_directory
      bindkey '^f' ghq_fzf_change_directory
    '';
    envExtra = ''
      if [ -e ~/.nix-profile/etc/profile.d/nix.sh ]; then
        . ~/.nix-profile/etc/profile.d/nix.sh
      fi
    '';
  };
}
