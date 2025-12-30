{ lib, ... }:
{
  plugins.mini.modules.sessions = { };
  keymaps = [
    {
      mode = "n";
      key = "<Leader>fs";
      action = lib.nixvim.mkRaw "MiniSessions.select";
      options.desc = "Open sessions switcher (mini.sessions)";
    }
  ];
}
