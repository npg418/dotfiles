{ ... }:
{
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    luaLoader.enable = true;
  };

  imports = [
    ./options.nix
    ./colorscheme.nix
    ./plugins
  ];
}
