{
  nixvim,
  lib,
  config,
  ...
}:
{
  programs.nixvim = {
    plugins.toggleterm = {
      enable = true;
      settings = {
        direction = "float";
        open_mapping = "\"<C-t>\"";
        hide_numbers = true;
        shading_factor = 2;
        on_create = lib.mkIf (builtins.hasAttr "indentscope" config.programs.nixvim.plugins.mini.modules) ''
          function()
            vim.b.miniindentscope_disable = true
          end
        '';
      };
    };

    userCommands = {
      HMSwitch = {
        command = nixvim.mkRaw ''
          function(opts)
            local term = require("toggleterm.terminal").Terminal:new({
              cmd = "home-manager switch",
              display_name = "Home manager switch",
              direction = "float",
              close_on_exit = true,
              on_exit = function(_, _, code, _)
                if code == 0 then
                  vim.cmd.source(vim.env.MYVIMRC)
                else
                  vim.api.nvim_echo({
                    { "An error occurred while switching home manager profile.\n", "ErrorMsg" },
                    { "Press any key to continue...", "WarningMsg" },
                  }, true, {})
                  vim.fn.getchar()
                end
              end,
              auto_scroll = true,
              hidden = true,
            })
            local mode = opts.fargs[1];
            if mode and mode == "bg" then
              term:spawn()
            else
              term:toggle()
            end
          end
        '';
        nargs = "?";
        complete = nixvim.mkRaw ''
          function()
            return { "fg", "bg" }
          end
        '';
        desc = "Run `home-manager switch` and reload & apply neovim settings (neovim)";
      };
    };
  };
}
