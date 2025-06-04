{ pkgs, ... }:
{
  plugins = {
    lsp.enable = true;
    neoconf.luaConfig.post = ''
      do
        local util = require("neoconf.util");
      end
    '';
  };
  extraPlugins = [ pkgs.vimPlugins.lazy-lsp-nvim ];
  extraConfigLua = ''
    do
      require("lazy-lsp").setup()
    end
  '';
}
