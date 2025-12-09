{ lib, ... }:
{
  plugins.blink-cmp = {
    enable = true;
    settings = {
      sources.default = lib.mkBefore [
        "lsp"
        "path"
        "snippets"
        "buffer"
      ];
      completion.documentation.auto_show = true;
      keymap.preset = "default";
    };
  };
}
