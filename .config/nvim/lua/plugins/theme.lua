return {
  {
    'morhetz/gruvbox',
    lazy = true,
    enable = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme 'gruvbox'
    end
  },
  {
    'folke/tokyonight.nvim',
    lazy = false,
    enable = true,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme 'tokyonight'
    end
  },
}
