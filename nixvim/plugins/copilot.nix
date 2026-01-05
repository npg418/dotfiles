{ lib, config, ... }:
let
  copilot-key = "<A-\\>";
in
{
  plugins = {
    copilot-lua.enable = true;

    blink-copilot.enable = config.plugins.blink-cmp.enable;

    blink-cmp.settings = {
      keymap.${copilot-key} = [
        (lib.nixvim.mkRaw ''
          function(cmp)
            cmp.show({ providers = { "copilot" } })
          end
        '')
      ];
      sources.providers.copilot = {
        name = "copilot";
        module = "blink-copilot";
        score_offset = 100;
        async = true;
      };
    };
  };
}
