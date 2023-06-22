vim.cmd('autocmd!')

-- エンコードはutf-8を使う
vim.scriptencoding = 'utf-8'

-- 2バイト文字を描画する
vim.o.ambiwidth = 'double'
-- メッセージ表示欄を1行確保
vim.o.cmdheight = 1
-- 絵文字を表示
vim.o.emoji = true

-- 行番号を表示
vim.wo.number = true

