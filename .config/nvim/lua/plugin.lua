require('jetpack')

vim.cmd('packadd vim-jetpack')
require('jetpack.paq') {
    {'tani/vim-jetpack'},
    'junegunn/fzf.vim',
    {'junegunn/fzf', run = './install' },
    'lambdalisue/fern.vim',
    'lambdalisue/nerdfont.vim',
    'lambdalisue/fern-renderer-nerdfont.vim',
}

vim.g['fern#renderer'] = 'nerdfont'
vim.g['fern#renderer#nerdfont#indent_markers'] = 1

