return {
  'akinsho/bufferline.nvim',
  version = '*',
  event = 'VimEnter',
  dependencies = 'nvim-tree/nvim-web-devicons',
  config = function()
    local bufferline = require 'bufferline'
    bufferline.setup({
      options = {
        indicator = {
          style = 'none'
        },
        diagnostics = 'nvim_lsp',
        show_buffer_close_icons = false,
        separator_style = {'', ''}
      },
      highlights = {
        fill = {
          bg = '#24283B'
        },
      }
    })
  end
}
