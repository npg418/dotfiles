{
  lib,
  pkgs,
  ...
}: {
  plugins.conform-nvim = {
    enable = true;
    settings = {
      default_format_opts = {
        lsp_format = "fallback";
      };
      formatters_by_ft = {
        "*" = ["flake_defined"];
        nix = ["alejandra"];
        lua = ["stylua"];
      };
      formatters = {
        flake_defined = {
          command = "nix";
          args = [
            "fmt"
            "$FILENAME"
          ];
          cwd = lib.nixvim.mkRaw ''
            require("conform.util").root_file({ "flake.nix" })
          '';
        };
      };
      format_on_save = {
        timeout_ms = 500;
      };
    };
  };

  extraPackages = with pkgs; [
    alejandra
    stylua
  ];
}
