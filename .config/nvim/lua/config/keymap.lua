-- 一括置換をやりやすくする
vim.cmd([[cnoreabbrev <expr> s getcmdtype() .. getcmdline() ==# ':s' ? [getchar(), ''][1] .. "%s///g<Left><Left>" : 's']])

-- root権限で保存
vim.keymap.set('c', 'w!!', 'w !sudo tee > /dev/null %')

-- bufferの切り替え
vim.keymap.set('n', '<C-l>', '<cmd>bnext<CR>')
vim.keymap.set('n', '<C-h>', '<cmd>bprevious<CR>')

-- ペインの切り替え
vim.keymap.set({ 'n', 't' }, '<A-j>', '<cmd>wincmd j<CR>')
vim.keymap.set({ 'n', 't' }, '<A-k>', '<cmd>wincmd k<CR>')
vim.keymap.set({ 'n', 't' }, '<A-h>', '<cmd>wincmd h<CR>')
vim.keymap.set({ 'n', 't' }, '<A-l>', '<cmd>wincmd l<CR>')

-- ペインを削除
vim.keymap.set({ 'n', 't' }, '<C-x>', '<cmd>quit<CR>')
