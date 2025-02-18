{ ... }:
{
  programs.nixvim.plugins.mini.modules.sessions = {
    autoread = true;
    autowrite = true;
  };
}
