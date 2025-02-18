{ ... }:
{
  programs.nixvim.plugins.treesitter = {
    enable = true;
    settings = {
      auto_install = true;
      ensure_installed = [ "nix" ];
    };
  };
}
