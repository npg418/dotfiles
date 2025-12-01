{
  programs = {
    git = {
      enable = true;
      settings = {
        user = {
          name = "NPG418";
          email = "narupenguin919@gmail.com";
        };
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
