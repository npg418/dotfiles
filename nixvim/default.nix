{
  viAlias = true;
  vimAlias = true;
  luaLoader.enable = true;

  imports = [
    ./options.nix
    ./colorscheme.nix
    ./plugins
    ./ftplugin.nix
    ./snippets
  ];
}
