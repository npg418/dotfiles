{
  plugins.lazygit.enable = true;
  keymaps = [
    {
      mode = "n";
      key = "<Leader>lg";
      action = "<Cmd>LazyGit<CR>";
      options.desc = "Open lazygit (lazygit)";
    }
  ];
}
