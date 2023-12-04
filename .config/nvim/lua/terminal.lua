vim.api.nvim_create_user_command('T', 'split | wincmd j | resize 20 | terminal', {})

vim.api.nvim_create_augroup('terminal', {})
vim.api.nvim_create_autocmd('TermOpen', {
  group = 'terminal',
  callback = function()
    vim.opt_local.relativenumber = false
    vim.opt_local.number = false
    vim.opt_local.bufhidden = 'hide'
    vim.cmd('startinsert')
  end
})
vim.api.nvim_create_autocmd('TermClose', {
  group = 'terminal',
  callback = function()
    vim.cmd('bwipe')
  end
})

vim.keymap.set('t', '<Esc>', '<C-\\><C-n>')
vim.keymap.set('n', '<A-t>', ':T<CR>')
vim.keymap.set('t', '<A-t>', '<C-c> exit<CR>')

if vim.fn.executable('pwsh') == 1 then
  vim.o.shell = 'pwsh'
end
