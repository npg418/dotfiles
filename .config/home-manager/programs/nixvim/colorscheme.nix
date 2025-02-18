{ ... }:
{
  programs.nixvim = {
    colorscheme = "catppuccin-macchiato";
    colorschemes.catppuccin = {
      enable = true;
      autoLoad = true;
    };
  };
}
