-- 一括置換をやりやすくする
vim.cmd [[cnoreabbrev <expr> s getcmdtype() .. getcmdline() ==# ':s' ? [getchar(), ''][1] .. "%s///g<Left><Left>" : 's']]

-- root権限で保存
vim.keymap.set('c', 'w!!', 'w !sudo tee > /dev/null %')

