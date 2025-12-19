{ lib, config, ... }:
let
  hasLazyConfig = builtins.any (
    entry: (builtins.hasAttr "lazyLoad" entry.value) && entry.value.lazyLoad.enable
  ) (lib.attrsToList config.plugins);
in
{
  plugins.lz-n.enable = hasLazyConfig;
}
