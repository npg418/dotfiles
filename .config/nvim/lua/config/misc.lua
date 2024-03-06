vim.cmd.highlight('LineNr guifg=grey')

vim.api.nvim_create_autocmd('BufWinEnter', {
  callback = function()
    if vim.bo.buftype == 'help' then
      vim.cmd.wincmd('L')
    end
  end,
})

vim.api.nvim_create_user_command('ClearReg', function()
  for i = 0, 25 do
    vim.fn.setreg(string.char(string.byte('a') + i), {})
    vim.fn.setreg(string.char(string.byte('A') + i), {})
  end
end, { desc = 'Clear a-Z registers.' })
