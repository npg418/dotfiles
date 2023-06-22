-- 自動で dein#recache_runtimepath() する
vim.api.nvim_set_var('dein#auto_recache', 1)
-- neovimのリモートプラグインを遅延読み込み
vim.api.nvim_set_var('dein#lazy_rplugins', 1)
-- 通知をオンにする
vim.api.nvim_set_var('dein#enable_notification', 1)
-- インストール時の最大プロセス数
vim.api.nvim_set_var('dein#install_max_processes', 16)
-- インストール時のメッセージタイプ
vim.api.nvim_set_var('dein#install_message_type', 'none')

-- dein.vimのインストール先
local dein_dir = vim.env.HOME .. '/.cache/dein'
local dein_repo_dir = dein_dir .. '/repos/github.com/Shougo/dein.vim'

-- dein.vimをインストール
if not string.match(vim.o.runtimepath, '/dein.vim') then
    if vim.fn.isdirectory(dein_repo_dir) ~= 1 then
        os.execute('git clone https://github.com/Shougo/dein.vim '..dein_repo_dir)
    end
    vim.o.runtimepath = dein_repo_dir .. ',' .. vim.o.runtimepath 
end

-- dein.vimの設定を読み込み
if vim.call('dein#load_state', dein_dir) == 1 then
    local dein_toml_dir = vim.env.HOME .. '/.config/nvim/dein'
    local dein_toml = dein_toml_dir .. '/base.toml'
    local dein_toml_lazy = dein_toml_dir .. '/lazy.toml'
    local dein_toml_python = dein_toml_dir .. '/python.toml'

    vim.call('dein#begin', dein_dir, {vim.fn.expand('<sfile>'), dein_toml, dein_toml_lazy, dein_toml_input})

    vim.call('dein#load_toml', dein_toml, {lazy = 0})
    vim.call('dein#load_toml', dein_toml_lazy, {lazy = 1})
    if vim.fn.has('python3') == 1 then
        vim.call('dein#load_toml', dein_toml_python, {lazy = 1})
    end
    vim.call('dein#end')
    vim.call('dein#save_state')
end
