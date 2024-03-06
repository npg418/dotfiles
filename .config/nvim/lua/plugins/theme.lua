return {
  {
    'morhetz/gruvbox',
    lazy = false,
    enable = false,
    priority = 1000,
    config = function()
      -- vim.cmd.colorscheme 'gruvbox'
    end,
  },
  {
    'folke/tokyonight.nvim',
    lazy = false,
    enable = false,
    priority = 1000,
    config = function()
      -- vim.cmd.colorscheme 'tokyonight'
    end,
  },
  {
    '4513ECHO/vim-colors-hatsunemiku',
    lazy = false,
    enable = true,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme('hatsunemiku')
      vim.o.termguicolors = true
      vim.cmd.highlight { 'link VertSplit NonText', bang = true }
      vim.o.fillchars = 'eob: ,vert:┃'
    end,
  },
}
