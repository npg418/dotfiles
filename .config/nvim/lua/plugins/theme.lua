---@type LazySpec
return {
  {
    'morhetz/gruvbox',
    lazy = false,
    priority = 1000,
    enabled = false,
    config = function()
      vim.cmd.highlight('gruvbox')
    end,
  },
  {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    enabled = false,
    config = function()
      vim.cmd.highlight('tokyonight')
    end,
  },
  {
    '4513ECHO/vim-colors-hatsunemiku',
    lazy = false,
    priority = 1000,
    enabled = true,
    config = function()
      vim.cmd.colorscheme('hatsunemiku')
      vim.o.termguicolors = true
      vim.cmd.highlight({ 'link VertSplit NonText', bang = true })
      vim.o.fillchars = 'eob: ,vert:┃'
    end,
  },
}
