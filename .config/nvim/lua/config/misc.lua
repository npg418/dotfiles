vim.cmd.highlight('LineNr guifg=grey')

vim.api.nvim_create_autocmd('BufWinEnter', {
  callback = function()
    if (vim.bo.buftype == 'help') then
      vim.cmd.wincmd('L')
    end
  end
})
