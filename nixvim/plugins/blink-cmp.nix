{
  plugins.blink-cmp = {
    enable = true;
    lazyLoad.settings.events = [ "InsertEnter" ];
    settings = {
      sources.default = [
        "lsp"
        "path"
        "snippets"
        "buffer"
      ];
      completion.documentation.auto_show = true;
      keymap.preset = "super-tab";
    };
  };
}
