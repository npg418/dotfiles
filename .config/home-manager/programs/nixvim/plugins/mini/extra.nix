{
  nixvim,
  lib,
  config,
  ...
}:
{
  programs.nixvim = {
    plugins.mini.modules.extra = { };
    keymaps = lib.optionals (builtins.hasAttr "pick" config.programs.nixvim.modules) [
      {
        mode = "n";
        keys = "<Leader>fc";
        action = nixvim.mkRaw "MiniExtra.pickers.commands";
        options.desc = "Open fuzzy command runner (mini.pick)";
      }
      {
        mode = "n";
        keys = "<Leader>fk";
        action = nixvim.mkRaw "MiniExtra.pickers.keymaps";
        options.desc = "Open keymap picker (mini.pick)";
      }
    ];
  };
}
