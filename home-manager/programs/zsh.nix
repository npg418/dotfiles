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
    envExtra = ''
      if [ -e ~/.nix-profile/etc/profile.d/nix.sh ]; then
        . ~/.nix-profile/etc/profile.d/nix.sh
      fi
    '';
  };
}
