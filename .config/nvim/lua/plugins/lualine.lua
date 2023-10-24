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
        lualine_c = {
          {
            'diagnostics',
            sources = { 'nvim_lsp' },
            symbols = { error = '', warn = '', info = '' },
          },
        },
        lualine_x = { 'encoding' },
        lualine_y = { 'filetype' },
        lualine_z = { 'fileformat' },
      },
      tabline = {
        lualine_a = {
          {
            'buffers',
            symbols = { modified = ' _󰷥', alternate_file = ' ', directory = ' ' },
          },
        },
        lualine_b = {},
        lualine_c = {},
        lualine_x = { 'diff' },
        lualine_y = { 'branch' },
        lualine_z = { 'tabs' },
      },
    })
    vim.o.showmode = false
  end,
}
