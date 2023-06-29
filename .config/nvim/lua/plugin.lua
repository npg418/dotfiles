local folderOfThisFile = (...):match('(.-)[^%.]+$')
require(folderOfThisFile .. '.jetpack')

vim.cmd('packadd vim-jetpack')
require('jetpack.paq') {
    {'tani/vim-jetpack'},
    'junegunn/fzf.vim',
    {'junegunn/fzf', run = './install' },
}
