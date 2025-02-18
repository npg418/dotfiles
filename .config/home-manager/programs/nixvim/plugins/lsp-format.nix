{ ... }:
{
  programs.nixvim = {
    plugins.lsp-format = {
      enable = true;
      lspServersToEnable = [ "efm" ];
    };
    keymaps = [
      {
        mode = "ca";
        key = "wq";
        action = "execute \"Format sync\" <Bar> wq";
        options.desc = "Autoformat when write and exit (lsp-format)";
      }
    ];
  };
}
