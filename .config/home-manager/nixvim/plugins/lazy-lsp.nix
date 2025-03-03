{ pkgs, ... }:
{
  plugins.lsp.enable = true;
  extraPlugins = [
    {
      plugin = pkgs.vimPlugins.lazy-lsp-nvim;
      type = "lua";
      config = ''
        do
          require("lazy-lsp").setup({})
        end
      '';
    }
  ];
}
