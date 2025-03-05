{
  programs = {
    git = {
      enable = true;
      userName = "NPG418";
      userEmail = "narupenguin919@gmail.com";
      extraConfig = {
        init = {
          defaultBranch = "main";
        };
        core = {
          autocrlf = "input";
          safecrlf = false;
        };
        alias = {
          root = "rev-parse --show-toplevel";
          tree = "log --graph --oneline --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset";
        };
      };
    };
    zsh.zsh-abbr.abbreviations.cdg = "cd $(git rev-parse --show-toplevel)";
  };
}
