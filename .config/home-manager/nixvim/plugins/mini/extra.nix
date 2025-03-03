{
  lib,
  config,
  ...
}:
{
  programs.nixvim = {
    plugins.mini.modules.extra = { };
    keymaps = lib.optionals (builtins.hasAttr "pick" config.plugins.mini.modules) [
      {
        mode = "n";
        keys = "<Leader>fc";
        action = lib.nixvim.mkRaw "MiniExtra.pickers.commands";
        options.desc = "Open fuzzy command runner (mini.pick)";
      }
      {
        mode = "n";
        keys = "<Leader>fk";
        action = lib.nixvim.mkRaw "MiniExtra.pickers.keymaps";
        options.desc = "Open keymap picker (mini.pick)";
      }
    ];
  };
}
