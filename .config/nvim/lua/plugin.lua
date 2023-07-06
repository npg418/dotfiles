require('jetpack')
vim.cmd('packadd vim-jetpack')
require('jetpack.paq') {
  {'tani/vim-jetpack'},
  'junegunn/fzf.vim',
  {'junegunn/fzf', run = './install'},
  'lambdalisue/fern.vim',
  'lambdalisue/nerdfont.vim',
  'lambdalisue/fern-renderer-nerdfont.vim',
  'neovim/nvim-lspconfig',
  'williamboman/mason.nvim',
  'williamboman/mason-lspconfig.nvim',
  'lewis6991/gitsigns.nvim',
  'folke/tokyonight.nvim',
  'hrsh7th/nvim-cmp',
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-path',
  'hrsh7th/cmp-nvim-lua',
  'hrsh7th/cmp-cmdline',
  'hrsh7th/vim-vsnip',
  'hrsh7th/cmp-vsnip',
  'onsails/lspkind.nvim',
  'nvimdev/lspsaga.nvim',
  'j-hui/fidget.nvim',
  'lukas-reineke/lsp-format.nvim',
}

vim.g['fern#renderer'] = 'nerdfont'
vim.g['fern#renderer#nerdfont#indent_markers'] = 1

require('gitsigns').setup()

vim.cmd[[colorscheme tokyonight]]
