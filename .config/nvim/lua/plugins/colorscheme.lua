---@type LazySpec
return {
  {
    'morhetz/gruvbox',
    lazy = false,
    priority = 1000,
  },
  {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
  },
  {
    '4513ECHO/vim-colors-hatsunemiku',
    lazy = false,
    priority = 1000,
    config = function()
      vim.o.termguicolors = true
      vim.cmd.highlight({ 'link VertSplit NonText', bang = true })
      vim.o.fillchars = 'eob: ,vert:┃'
    end,
  },
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    lazy = false,
    priority = 1000,
  },
}
