return {
  'nvim-lualine/lualine.nvim',
  event = 'VimEnter',
  config = function()
    vim.o.laststatus = 3
    require'lualine'.setup({
      options = {
        globalstatus = true,
      },
    })
  end,
}