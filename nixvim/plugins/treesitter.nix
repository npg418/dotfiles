{
  plugins.treesitter = {
    enable = true;
    settings = {
      auto_install = true;
      highlight.enable = true;
      ensure_installed = [ "nix" ];
    };
  };
}
