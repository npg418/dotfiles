{ ... }:
{
  programs.nixvim.plugins = {
    lsp = {
      enable = true;
      inlayHints = true;
      keymaps =
        let
          withDesc = action: desc: {
            inherit action;
            desc = "${desc} (neovim)";
          };
        in
        {
          diagnostic = {
            "g]" = withDesc "goto_next" "Goto next diagnostic";
            "g[" = withDesc "goto_prev" "Goto previous diagnostic";
            ge = withDesc "open_float" "Open diagnostic float";
          };
          lspBuf = {
            gr = withDesc "references" "Jump to the references";
            gd = withDesc "definition" "Jump to the definition";
            gD = withDesc "declaration" "Jump to the declaration";
            gi = withDesc "implementation" "Jump to the implementation";
            gt = withDesc "type_definition" "Jump to the type definition";
            gf = withDesc "format" "Format current file";
            gn = withDesc "rename" "Rename symbol under cursor";
            "g." = withDesc "code_action" "Do code action under cursor";
            K = withDesc "hover" "Hover on symbol under cursor";
          };
        };
      servers = {
        nil_ls.enable = true;
        efm.enable = true;
      };
    };
    efmls-configs = {
      enable = true;
      setup.nix.formatter = "nixfmt";
    };
  };
}
