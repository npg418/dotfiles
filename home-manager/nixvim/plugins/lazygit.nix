{
  plugins.lazygit.enable = true;
  keymaps = [
    {
      mode = "n";
      key = "<Leader>gg";
      action = "<Cmd>LazyGit<CR>";
      options.desc = "Open lazygit (lazygit)";
    }
  ];
}
