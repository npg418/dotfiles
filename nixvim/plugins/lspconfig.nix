{
  lib,
  config,
  ...
}:
{
  plugins.lsp = {
    enable = true;
    inlayHints = true;
    keymaps =
      let
        usedKeys = map (def: def.key) config.keymaps;
        createKeymap =
          definition:
          let
            filtered = lib.filterAttrs (key: opts: !(builtins.elem key usedKeys)) definition;
            descripted = builtins.mapAttrs (
              key: opts: { desc = "Neovim lsp action ${opts.action}"; } // opts
            ) filtered;
          in
          builtins.mapAttrs (key: opts: opts // { desc = opts.desc + " (Neovim)"; }) descripted;
      in
      {
        diagnostic = createKeymap {
          "g]" = {
            action = "goto_next";
            desc = "Goto next diagnostic";
          };
          "g[" = {
            action = "goto_prev";
            desc = "Goto previous diagnostic";
          };
          ge = {
            action = "open_float";
            desc = "Open diagnostic float";
          };
        };
        lspBuf = createKeymap {
          gr = {
            action = "references";
            desc = "Jump to the references";
          };
          gd = {
            action = "definition";
            desc = "Jump to the definition";
          };
          gD = {
            action = "declaration";
            desc = "Jump to the declaration";
          };
          gi = {
            action = "implementation";
            desc = "Jump to the implementation";
          };
          gt = {
            action = "type_definition";
            desc = "Jump to the type definition";
          };
          gf = {
            action = "format";
            desc = "Format current file";
          };
          gn = {
            action = "rename";
            desc = "Rename symbol under cursor";
          };
          "g." = {
            action = "code_action";
            desc = "Do code action under cursor";
          };
          K = {
            action = "hover";
            desc = "Hover on symbol under cursor";
          };
        };
      };
  };
}
