{ ... }:
{
  programs.nixvim.plugins.mini = {
    modules.notify = { };
    luaConfig.post = "vim.notify = MiniNotify.make_notify()";
  };
}
