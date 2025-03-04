{ pkgs, ... }:
{
  plugins.lsp.enable = true;
  extraPlugins = [ pkgs.vimPlugins.lazy-lsp-nvim ];
  extraConfigLua = ''
    do
      require("lazy-lsp").setup()
    end
  '';
}
