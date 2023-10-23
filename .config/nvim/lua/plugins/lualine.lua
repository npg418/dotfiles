return {
  'nvim-lualine/lualine.nvim',
  event = 'VimEnter',
  config = function()
    require 'lualine'.setup({
      options = {
        globalstatus = true,
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = {
          {
            'filename',
            newfile_status = true,
            path = 1,
            shorting_target = 24,
            symbols = { modified = '', readonly = '', newfile = '' },
          },
        },
      }
    })
  end,
}
