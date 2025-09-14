{ pkgs, ... }:
{
  extraPlugins = [
    {
      plugin = pkgs.vimPlugins.text-case-nvim;
      config = "lua require(\"textcase\").setup({})";
    }
  ];
  # extraConigLua = ''
  #   require("textcase").setup({})
  # '';
}
