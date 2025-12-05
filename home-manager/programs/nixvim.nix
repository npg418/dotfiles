{
  programs = {
    nixvim = {
      enable = true;
      defaultEditor = true;
      vimdiffAlias = true;
    };

    zsh.zsh-abbr.abbreviations.v = "nvim";
  };
}
