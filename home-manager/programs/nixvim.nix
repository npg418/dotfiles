{
  programs = {
    nixvim =
      { lib, ... }:
      {
        enable = true;
        defaultEditor = true;
        vimdiffAlias = true;

        userCommands.HMSwitch = {
          command = lib.nixvim.mkRaw ''
            function()
              vim.fn.system("home-manager switch")
              vim.cmd.source("$MYVIMRC")
            end
          '';
        };
      };

    zsh.zsh-abbr.abbreviations.v = "nvim";
  };
}
