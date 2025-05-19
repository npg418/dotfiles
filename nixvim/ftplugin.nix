{ lib, config, ... }:
{
  extraFiles = {
    "ftplugin/nix.lua".text =
      let
        hasMiniPairs = config.plugins.mini.enable && (builtins.hasAttr "pairs" config.plugins.mini.modules);
      in
      lib.optionalString hasMiniPairs ''
        MiniPairs.unmap_buf(0, "i", "'", "'\'")
      '';
  };
}
