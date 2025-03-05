{ pkgs, ... }:
{
  plugins.hardtime.enable = true;
  extraPlugins = [ pkgs.vimPlugins.plenary-nvim ];
}
