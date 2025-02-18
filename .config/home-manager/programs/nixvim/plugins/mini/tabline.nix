{ nixvim, ... }:
{
  programs.nixvim.plugins.mini.modules.tabline = {
    format = nixvim.mkRaw ''
      function(buf_id, label)
        local suffix = ""
        if vim.bo[buf_id].modified then
          suffix = "● "
        elseif vim.bo[buf_id].readonly then
          suffix = " "
        end
        return MiniTabline.default_format(buf_id, label) .. suffix
      end
    '';
  };
}
