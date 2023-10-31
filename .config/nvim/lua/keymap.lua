-- 一括置換をやりやすくする
vim.cmd [[cnoreabbrev <expr> s getcmdtype() .. getcmdline() ==# ':s' ? [getchar(), ''][1] .. "%s///g<Left><Left>" : 's']]

-- root権限で保存
vim.keymap.set('c', 'w!!', 'w !sudo tee > /dev/null %')

-- bufferの切り替え
vim.keymap.set('n', '<C-l>', '<cmd>bnext<CR>')
vim.keymap.set('n', '<C-h>', '<cmd>bprevious<CR>')

-- ペインの切り替え
vim.keymap.set('n', '<A-j>', '<C-w>j')
vim.keymap.set('n', '<A-k>', '<C-w>k')
vim.keymap.set('n', '<A-h>', '<C-w>h')
vim.keymap.set('n', '<A-l>', '<C-w>l')
