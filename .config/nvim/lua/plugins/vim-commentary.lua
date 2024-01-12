return {
  'tpope/vim-commentary',
  enabled = false,
  keys = {
    '<C-_>',
    { '<C-_>', mode = 'v' },
  },
  config = function()
    vim.keymap.set('n', '<C-_>', 'gcc', { remap = true, silent = true })
    vim.keymap.set('v', '<C-_>', 'gc', { remap = true, silent = true })
  end,
}
