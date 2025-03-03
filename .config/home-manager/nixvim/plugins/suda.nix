{
  plugins.vim-suda = {
    enable = true;
    settings.smart_edit = 1;
  };

  keymaps = [
    {
      mode = "ca";
      key = "e!!";
      action = "SudaRead";
      options.desc = "Open file with suda (suda)";
    }
    {
      mode = "ca";
      key = "w!!";
      action = "SudaWrite";
      options.desc = "Write file with suda (suda)";
    }
  ];
}
