{ lib, pkgs, ... }:
{
  plugins.conform-nvim = {
    enable = true;
    settings = {
      default_format_opts = {
        lsp_format = "fallback";
      };
      formatters_by_ft = {
        "*" = [ "treefmt" ];
        nix = [ "nixfmt" ];
        lua = [ "stylua" ];
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
            require("conform.util").root_file({ "treefmt.toml", "treefmt.nix", "devenv.nix", "flake.nix" })
          '';
          require_cwd = true;
        };
        flake_defined = {
          command = "nix";
          args = [
            "fmt"
            "$FILENAME"
          ];
          cwd = lib.nixvim.mkRaw ''
            require("conform.util").root_file({ "flake.nix" })
          '';
          require_cwd = true;
        };
      };
      format_on_save = {
        timeout_ms = 500;
      };
    };
  };

  extraPackages = with pkgs; [
    nixfmt-rfc-style
    stylua
  ];
}
