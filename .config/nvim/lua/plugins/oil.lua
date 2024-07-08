---@type LazySpec
return {
  'stevearc/oil.nvim',
  enabled = true,
  dependencies = 'nvim-tree/nvim-web-devicons',
  keys = {
    { '<C-n>', '<cmd>Oil --float<CR>' },
  },
  config = function()
    local oil = require('oil')

    oil.setup({
      delete_to_trash = true,
      float = {
        preview_split = 'right',
      },
      keymaps = {
        ['q'] = 'actions.close',
        ['<C-n>'] = 'actions.close',
        ['<C-u>'] = 'actions.preview_scroll_up',
        ['<C-d>'] = 'actions.preview_scroll_down',
      },
    })
  end,
}
