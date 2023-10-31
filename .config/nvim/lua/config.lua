-- エンコードはutf-8を使う
vim.scriptencoding = 'utf-8'

-- 2バイト文字を描画する
-- vim.o.ambiwidth = 'double'

-- メッセージ表示欄を1行確保
vim.o.cmdheight = 1

-- 絵文字を表示
vim.o.emoji = true

-- 行番号を表示(相対)
vim.o.number = true
vim.o.relativenumber = true

-- サインコラムを表示
vim.o.signcolumn = 'yes'

-- クリップボードを共有
vim.o.clipboard = 'unnamedplus'

-- インデント設定
vim.o.expandtab = true
vim.o.shiftwidth = 2
vim.o.breakindent = true
vim.o.autoindent = true

--フォーマット設定
vim.api.nvim_create_autocmd({ 'BufEnter' }, {
  callback = function()
    vim.o.formatoptions = 'tcqnjp'
  end,
})

-- swapファイルを作成しない
vim.o.swapfile = false

-- undoファイルを保存する
vim.o.undofile = true

-- updatetimeを遅くする
vim.o.updatetime = 250
vim.o.timeout = true
vim.o.timeoutlen = 300

-- 検索をやりやすく
vim.o.incsearch = true

-- ステータスラインを常に表示
vim.o.laststatus = 3
