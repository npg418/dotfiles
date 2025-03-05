{ lib, ... }:
{
  plugins = {
    conform-nvim = {
      enable = true;
      settings = {
        formatters_by_ft."*" = [ "treefmt" ];
        formatters = {
          treefmt = {
            command = "treefmt";
            args = [
              "--allow-missing-formatter"
              "--stdin"
              "$FILENAME"
            ];
            stdin = true;
            cwd = lib.nixvim.mkRaw "require(\"conform.util\").root_file({ \"treefmt.toml\" })";
            require_cwd = true;
            # FUCK: range_args can't be added until [numtide/treefmt#276](https://github.com/numtide/treefmt/issues/276) resolve
          };
        };
        format_on_save = {
          lsp_format = "fallback";
          timeout_ms = 500;
        };
      };
    };
    lsp.keymaps.lspBuf.gf = lib.mkIf false { };
  };

  keymaps = [
    {
      mode = "n";
      key = "gf";
      action = lib.nixvim.mkRaw ''
        function()
          require("conform").format({ async = true })
        end
      '';
      options.desc = "Format with conform (conform)";
    }
  ];
}
