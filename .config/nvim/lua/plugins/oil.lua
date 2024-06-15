---@type LazySpec
return {
  'stevearc/oil.nvim',
  enabled = false,
  dependencies = 'nvim-tree/nvim-web-devicons',
  keys = {
    { '<C-n>', '<cmd>Oil<cr>' },
  },
  cmd = 'Oil',
  opts = {},
}
