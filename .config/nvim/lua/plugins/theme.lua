return {
  {
    'morhetz/gruvbox',
    event = 'VimEnter',
    priority = 1000,
    config = function()
      vim.cmd.colorscheme 'gruvbox'
    end
  },
}