{
  programs = {
    eza = {
      enable = true;
      git = true;
      icons = "auto";
    };
    zsh.zsh-abbr.abbreviations = {
      ls = "eza";
      ll = "eza -hlg";
      la = "eza -hlga";
    };
  };
}
