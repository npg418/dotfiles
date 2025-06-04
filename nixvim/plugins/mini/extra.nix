{
  lib,
  config,
  ...
}:
{
  plugins.mini.modules.extra = { };
  keymaps = lib.mkIf (builtins.hasAttr "pick" config.plugins.mini.modules) [
    {
      mode = "n";
      key = "<Leader>fc";
      action = lib.nixvim.mkRaw "MiniExtra.pickers.commands";
      options.desc = "Open fuzzy command runner (mini.pick)";
    }
    {
      mode = "n";
      key = "<Leader>fk";
      action = lib.nixvim.mkRaw "MiniExtra.pickers.keymaps";
      options.desc = "Open keymap picker (mini.pick)";
    }
  ];
}
