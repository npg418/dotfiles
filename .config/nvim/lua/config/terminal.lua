vim.api.nvim_create_augroup('terminal', {})
vim.api.nvim_create_autocmd('TermOpen', {
  group = 'terminal',
  callback = function()
    vim.opt_local.relativenumber = false
    vim.opt_local.number = false
    vim.opt_local.bufhidden = 'wipe'
    vim.opt_local.buflisted = false
    vim.cmd.startinsert()
  end,
})
vim.api.nvim_create_autocmd('TermClose', {
  group = 'terminal',
  callback = function()
    vim.cmd.close({ bang = true })
  end,
})
vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter' }, {
  group = 'terminal',
  pattern = 'term://*',
  callback = function()
    vim.cmd.startinsert()
  end,
})

vim.keymap.set('t', '<Esc>', '<C-\\><C-n>')
vim.keymap.set('n', '<A-t>', ':split | wincmd j | resize 20 | terminal<CR>')
vim.keymap.set('t', '<A-t>', '<C-c> exit<CR>:q<CR>')

if vim.fn.executable('pwsh') == 1 then
  vim.o.shell = 'pwsh'
end
