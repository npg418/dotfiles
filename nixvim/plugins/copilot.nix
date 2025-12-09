{ lib, config, ... }:
{
  plugins = {
    copilot-lua.enable = true;
    blink-copilot.enable = config.plugins.blink-cmp.enable;
    blink-cmp.settings.sources = {
      default = lib.mkAfter [ "copilot" ];
      providers.copilot = {
        name = "copilot";
        module = "blink-copilot";
        score_offset = 100;
        async = true;
      };
    };
  };
}
