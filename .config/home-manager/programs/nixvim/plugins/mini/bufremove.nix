{ nixvim, ... }:
{
  programs.nixvim = {
    plugins.mini.modules.bufremove = { };
    keymaps = [
      {
        mode = "n";
        key = "<Leader>c";
        action = nixvim.mkRaw "MiniBufremove.delete";
        options.desc = "Delete current buffer (mini.bufremove)";
      }
      {
        mode = "n";
        key = "<Leader>bb";
        action = nixvim.mkRaw ''
          function()
            vim.cmd("b#")
            vim.opt_local.buflisted = true
          end
        '';
        options.desc = "Restore last deleted buffer (mini.bufremove)";
      }
      {
        mode = "n";
        key = "<Leader>bc";
        action = nixvim.mkRaw ''
          function()
            local current = vim.api.nvim_get_current_buf()
            for _, buf_id in ipairs(vim.api.nvim_list_bufs()) do
              if buf_id ~= current and vim.bo[buf_id].buflisted then
                MiniBufremove.delete(buf_id)
              end
            end
          end
        '';
        options.desc = "Delete all buffer but preserve current one (mini.bufremove)";
      }
    ];
  };
}
