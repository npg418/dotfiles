---@type LazySpec
return {
  'akinsho/toggleterm.nvim',
  version = '*',
  cmd = 'ToggleTerm',
  keys = '<A-t>',
  config = function()
    require('toggleterm').setup(
      ---@type ToggleTermConfig
      {
        open_mapping = '<A-t>',
        direction = 'float',
      }
    )
  end,
}
