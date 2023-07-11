require('jetpack')
vim.cmd('packadd vim-jetpack')
require('jetpack.paq') {
  'tani/vim-jetpack',
  'junegunn/fzf.vim',
  { 'junegunn/fzf', run = './install' },
  'lambdalisue/fern.vim',
  'lambdalisue/nerdfont.vim',
  'lambdalisue/fern-renderer-nerdfont.vim',
  'lambdalisue/fern-git-status.vim',
  'lambdalisue/glyph-palette.vim',
  'yuki-yano/fern-preview.vim',
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
  'vim-airline/vim-airline',
  {
    'vim-airline/vim-airline-themes',
    run =
    'mkdir -p ~/.local/share/nvim/site/autoload/airline/themes && cd $_ && curl -O https://raw.githubusercontent.com/ghifarit53/tokyonight-vim/master/autoload/airline/themes/tokyonight.vim'
  },
  'ryanoasis/vim-devicons',
  'tpope/vim-commentary',
}

vim.g['fern#renderer'] = 'nerdfont'
vim.g['fern#renderer#nerdfont#indent_markers'] = 1

require('gitsigns').setup()

vim.cmd [[colorscheme tokyonight]]
