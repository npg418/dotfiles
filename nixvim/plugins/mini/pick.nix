{
  lib,
  pkgs,
  ...
}:
{
  plugins.mini = {
    modules.pick = { };
    luaConfig.post = "vim.ui.select = MiniPick.ui_select";
  };

  keymaps = [
    {
      mode = "n";
      key = "<Leader>fg";
      action = lib.nixvim.mkRaw "MiniPick.builtin.grep_live";
      options.desc = "Open live fuzzy finder (mini.pick)";
    }
    {
      mode = "n";
      key = "<Leader>fh";
      action = lib.nixvim.mkRaw "MiniPick.builtin.help";
      options.desc = "Open help search (mini.pick)";
    }
    {
      mode = "n";
      key = "<Leader>fb";
      action = lib.nixvim.mkRaw "MiniPick.builtin.buffers";
      options.desc = "Switch buffers by query (mini.pick)";
    }
    {
      mode = "n";
      key = "<Leader>ff";
      action = lib.nixvim.mkRaw "MiniPick.builtin.resume";
      options.desc = "Reopen last pickerOpen help search (mini.pick)";
    }
    {
      mode = "n";
      key = "<Leader>fp";
      action = lib.nixvim.mkRaw ''
        function()
          local pickers = MiniPick.builtin;
          if MiniExtra and MiniExtra.pickers then
            pickers = vim.tbl_extend("force", pickers, MiniExtra.pickers)
          end
          MiniPick.start({
            source = {
              name = '"Picker" picker',
              items = vim.tbl_keys(pickers),
              choose = function(item)
                pickers[item]()
              end,
            },
          })
        end
      '';
      options.desc = "Open \"picker\" picker (mini.pick)";
    }
  ];

  extraPackages = [ pkgs.ripgrep ];
}
