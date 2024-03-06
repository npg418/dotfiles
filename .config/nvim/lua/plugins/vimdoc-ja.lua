return {
  'vim-jp/vimdoc-ja',
  lazy = true,
  keys = {
    { 'h', mode = 'c' },
  },
  config = function()
    vim.o.helplang = 'ja,en'
  end,
}
