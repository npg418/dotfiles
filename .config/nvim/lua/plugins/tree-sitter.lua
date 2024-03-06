---@diagnostic disable: missing-fields
return {
  'nvim-treesitter/nvim-treesitter',
  run = ':TSUpdate',
  event = 'BufRead',
  dependencies = {
    'windwp/nvim-ts-autotag',
  },
  config = function()
    require('nvim-treesitter.configs').setup({
      ensure_installed = { 'lua' },
      sync_install = true,
      auto_install = true,

      highlight = {
        enable = true,
      },
      autotag = {
        enable = true,
      },
    })
  end,
}
