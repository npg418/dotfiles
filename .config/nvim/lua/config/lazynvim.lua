-- lazy.nvim(パッケージマネージャー)のセットアップ
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- デフォルトの設定
---@type LazyConfig
local opts = {
  defaults = {
    lazy = true,
  },
  performance = {
    cache = {
      enabled = true,
    },
  },
  change_detection = {
    notify = false,
  },
  install = {
    colorscheme = { 'hatsunemiku' },
  },
  ui = {
    border = 'single',
    title = 'Lazy',
  },
}

-- プラグインスペックを`lua/plugins`から読み取る
require('lazy').setup('plugins', opts)
