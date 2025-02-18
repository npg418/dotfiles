{ pkgs, nixvim, ... }:
{
  programs.nixvim = {
    extraPlugins = [
      (pkgs.vimUtils.buildVimPlugin {
        name = "fzy-lua-native";
        src = pkgs.fetchFromGitHub {
          owner = "romgrk";
          repo = "fzy-lua-native";
          rev = "9d720745d5c2fb563c0d86c17d77612a3519c506";
          hash = "sha256-pBV5iGa1+5gtM9BcDk8I5SKoQ9sydOJHsmyoBcxAct0=";
        };
      })
      (pkgs.vimUtils.buildVimPlugin {
        name = "care-nvim";
        src = pkgs.fetchFromGitHub {
          owner = "max397574";
          repo = "care.nvim";
          rev = "dba715ef083e1df2a7d47bd45d0b66e34ca5bba9";
          hash = "sha256-I0zliEcat3/Neb323VM0iyrrbAwH2wFuVF1V0M0BH7o=";
        };
      })
    ];
    extraConfigLua = ''
      local labels = {}
      for i=1,9 do
        labels[i] = tostring(i)
      end

      require("care").setup({
        ui = {
          ghost_text = {
            enabled = true,
            position = "inline",
          },
          menu = {
            format_entry = function(entry, data)
              local components = require("care.presets.components")
              return {
                components.Padding(1),
                components.ShortcutLabel(labels, entry, data),
                components.Padding(1),
                components.KindIcon(entry, "blended"),
                components.Padding(1),
                components.Label(entry, data, true),
                components.Padding(1),
                components.KindName(entry, true),
                components.Padding(1),
              }
            end,
          },
        },
      })
    '';
    keymaps = [
      {
        mode = "i";
        key = "<CR>";
        action = nixvim.mkRaw ''
          function()
            local api = require("care").api
            if api.get_index() ~= 0 then
              api.confirm()
            else
              vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<CR>", true, true, true), "n", false)
            end
          end
        '';
        options.desc = "Confirm currently selected canditate (care)";
      }
      {
        mode = "i";
        key = "<Tab>";
        action = "<Plug>(CareSelectNext)";
        options.desc = "Select next candidate (care)";
      }
      {
        mode = "i";
        key = "<S-Tab>";
        action = "<Plug>(CareSelectPrev)";
        options.desc = "Select previous candidate (care)";
      }
      {
        mode = "i";
        key = "<C-d>";
        action = nixvim.mkRaw ''
          function()
            local api = require("care").api
            if api.doc_is_open() then
              api.scroll_docs(4)
            else
              vim.api.nvim_feedkeys(vim.keycode("<C-d>"), "n", false)
            end
          end
        '';
        options.desc = "Scroll down docs (care)";
      }
      {
        mode = "i";
        key = "<C-u>";
        action = nixvim.mkRaw ''
          function()
            local api = require("care").api
            if api.doc_is_open() then
              api.scroll_docs(-4)
            else
              vim.api.nvim_feedkeys(vim.keycode("<C-u>"), "n", false)
            end
          end
        '';
        options.desc = "Scroll up docs (care)";
      }
    ];
  };
}
