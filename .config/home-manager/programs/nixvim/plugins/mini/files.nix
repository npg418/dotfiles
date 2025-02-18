{ nixvim, ... }:
{
  programs.nixvim = {
    plugins.mini.modules.files = { };
    plugins.hardtime.settings.restricted_keys."<C-N>" = nixvim.emptyTable;
    keymaps = [
      {
        mode = "n";
        key = "<C-n>";
        action = nixvim.mkRaw "MiniFiles.open";
        options.desc = "Open file explorer (mini.files)";
      }
    ];

    # FUCK: https://github.com/nix-community/nixvim/issues/2359 is stil open and no solution there
    files."ftplugin/minifiles.lua" = {
      keymaps = [
        {
          mode = "ca";
          key = "w";
          action = "lua MiniFiles.synchronize()";
          options = {
            buffer = true;
            desc = "Make :w work like other normal buffers (mini.files)";
          };
        }
        {
          mode = "n";
          key = "<C-n>";
          action = nixvim.mkRaw "MiniFiles.close";
          options = {
            buffer = true;
            desc = "Close file explorer (toggle behavior) (mini.files)";
          };
        }
      ];
    };
  };
}
