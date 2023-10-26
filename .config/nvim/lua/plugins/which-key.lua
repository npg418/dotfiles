return {
  'folke/which-key.nvim',
  cmd = {
    'WhichKey',
  },
  init = function ()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  opt = {},
}
