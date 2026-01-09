{ lib, ... }:
{
  plugins.conform-nvim = {
    enable = true;
    settings = {
      default_format_opts = {
        lsp_format = "first";
      };
      format_on_save = {
        timeout_ms = 500;
      };
      formatters_by_ft = {
        "*" = [ "treefmt" ];
      };
      formatters = {
        treefmt = {
          command = "treefmt";
          args = [
            "--allow-missing-formatter"
            "--stdin"
            "$FILENAME"
          ];
          stdin = true;
          cwd = lib.nixvim.mkRaw ''
            require("conform.util").root_file({ "treefmt.toml", "treefmt.nix", "flake.nix" })
          '';
          require_cwd = true;
        };
      };
    };
  };
}
