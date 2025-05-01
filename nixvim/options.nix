{ lib, ... }:
let
  group = "General neovim settings";
in
{
  clipboard = {
    register = [ "unnamedplus" ];
    providers.wl-copy.enable = true;
  };

  diagnostics = {
    virtual_text = {
      format = lib.nixvim.mkRaw ''
        function(diagnostic)
          return string.format("%s (%s: %s)", diagnostic.message, diagnostic.source, diagnostic.code)
        end
      '';
    };
    signs = {
      text = lib.nixvim.toRawKeys {
        "vim.diagnostic.severity.ERROR" = "";
        "vim.diagnostic.severity.WARN" = "";
        "vim.diagnostic.severity.INFO" = "";
        "vim.diagnostic.severity.HINT" = "";
      };
    };
  };

  autoGroups.${group} = { };
  autoCmd = map (autocmd: autocmd // { inherit group; }) [
    {
      event = "BufWinEnter";
      callback = lib.nixvim.mkRaw ''
        function()
          if vim.bo.buftype == "help" then
            vim.cmd.wincmd("L")
          end
        end
      '';
      desc = "Automatically move help window left (neovim)";
    }
    {
      event = "FileType";
      pattern = [
        "qf"
        "checkhealth"
      ];
      callback = lib.nixvim.mkRaw ''
        function()
          vim.opt_local.buflisted = false;
        end
      '';
      desc = "Make quickfix and checkhealth buffer unlisted (neovim)";
    }
    {
      event = "BufLeave";
      callback = lib.nixvim.mkRaw ''
        function()
          if vim.bo.buftype == "quickfix" then
            vim.cmd.cclose()
          end
        end
      '';
      desc = "Auto close quickfix window (neovim)";
    }
  ];

  keymaps = [
    {
      mode = "ca";
      key = "wqa";
      action = "wa|qa";
      options = {
        remap = true;
        desc = "To correctly quit from terminal buffer (neovim)";
      };
    }
    {
      mode = "t";
      key = "<ESC>";
      action = "<C-\\\><C-n>";
      options.desc = "Use ordinary keybind when in terminal mode (neovim)";
    }
    {
      mode = "n";
      key = "<Leader>h";
      action = "<Cmd>nohlsearch<CR>";
      options.desc = "Clear searching result (neovim)";
    }
  ];

  userCommands.ClearReg = {
    command = lib.nixvim.mkRaw ''
      function()
        for i = 0, 25 do
          vim.fn.setreg(string.char(string.byte("a") + i), {})
        end
      end
    '';
    desc = "Clear a-z registers (neovim)";
  };

  opts = {
    # General
    updatetime = 100;
    encoding = "utf-8";
    emoji = true;
    swapfile = false;
    undofile = true;
    timeout = true;
    timeoutlen = 500;
    termguicolors = true;

    # Gutter
    number = true;
    relativenumber = true;
    signcolumn = "yes";

    # Indentation
    expandtab = true;
    shiftwidth = 2;
    breakindent = true;
    autoindent = true;
    smartindent = true;

    # Splits
    splitbelow = true;
    splitright = true;

    # Commandline
    laststatus = 3;
    cmdheight = 1;

    # Search
    incsearch = true;
    inccommand = "split";
    ignorecase = true;
    smartcase = true;

    # Scroll
    scrolloff = 8;
    wrap = true;
  };
}
