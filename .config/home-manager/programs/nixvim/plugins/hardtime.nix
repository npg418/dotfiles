{ pkgs, ... }:
{
  programs.nixvim = {
    plugins.hardtime.enable = true;
    extraPlugins = [ pkgs.vimPlugins.plenary-nvim ];
  };
}
