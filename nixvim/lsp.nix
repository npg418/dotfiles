{
  lib,
  config,
  ...
}:
{
  plugins.lspconfig.enable = true;
  lsp = {
    servers =
      let
        lsps = [
          "nil_ls"
          "lua_ls"
          "yamlls"
          "ruff"
          "ts_ls"
          "dockerls"
          "docker_compose_language_service"
        ];
      in
      lib.genAttrs lsps (_: {
        enable = true;
      });
    keymaps = map (def: def // { mode = "n"; }) [
      {
        key = "g]";
        action = lib.nixvim.mkRaw "function() vim.diagnostic.jump({ count = 1, float = true }) end";
        options.desc = "Goto next diagnostic (Neovim diagnostic)";
      }
      {
        key = "g[";
        action = lib.nixvim.mkRaw "function() vim.diagnostic.jump({ count = -1, float = true }) end";
        options.desc = "Goto previous diagnostic (Neovim diagnostic)";
      }
      {
        key = "ge";
        action = lib.nixvim.mkRaw "function() vim.diagnostic.open_float() end";
        options.desc = "Open diagnostic info window (Neovim diagnostic)";
      }
      {
        key = "gr";
        lspBufAction = "references";
        options.desc = "Goto the references (Neovim lsp)";
      }
      {
        key = "gd";
        action = "definition";
        options.desc = "Goto the definition (Neovim lsp)";
      }
      {
        key = "gD";
        lspBufAction = "declaration";
        options.desc = "Goto the declaration (Neovim lsp)";
      }
      {
        key = "gi";
        lspBufAction = "implementation";
        options.desc = "Goto the implementation (Neovim lsp)";
      }
      {
        key = "gt";
        lspBufAction = "type_definition";
        options.desc = "Goto the type definition (Neovim lsp)";
      }
      (
        let
          hasConform = config.plugins.conform-nvim.enable;
        in
        {
          key = "gf";
          action = lib.nixvim.mkRaw ''
            function()
              ${if hasConform then "require('conform')" else "vim.lsp.buf"}.format()
            end
          '';
          options.desc =
            if hasConform then "Format with conform (Conform)" else "Format current file (Neovim lsp)";
        }
      )
      {
        key = "gn";
        lspBufAction = "rename";
        options.desc = "Rename symbol under cursor (Neovim lsp)";
      }
      {
        key = "g.";
        lspBufAction = "code_action";
        options.desc = "Do code action under cursor (Neovim lsp)";
      }
      {
        key = "K";
        lspBufAction = "hover";
        options.desc = "Hover on symbol under cursor (Neovim lsp)";
      }
    ];
  };
}
