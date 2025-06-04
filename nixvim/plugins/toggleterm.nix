{
  lib,
  config,
  ...
}:
{
  plugins.toggleterm = {
    enable = true;
    settings = {
      direction = "float";
      open_mapping = "\"<C-t>\"";
      hide_numbers = true;
      shading_factor = 2;
      on_create = lib.mkIf (builtins.hasAttr "indentscope" config.plugins.mini.modules) ''
        function()
          vim.b.miniindentscope_disable = true
        end
      '';
    };
  };
}
