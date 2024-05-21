---@type LazySpec
return {
  'ziontee113/color-picker.nvim',
  keys = {
    { '<C-c>', '<cmd>PickColor<cr>', mode = 'n' },
    { '<C-c>', '<cmd>PickColorInsert<cr>', mode = 'i' },
  },
  config = function()
    require('color-picker').setup()
  end,
}
