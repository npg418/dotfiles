vim.api.nvim_create_user_command('T', 'split | wincmd j | resize 20 | terminal', {})

vim.api.nvim_create_augroup('terminal-autoinsert', {})
vim.api.nvim_create_autocmd('TermOpen', {
  group = 'terminal-autoinsert',
  callback = function ()
    vim.opt_local.relativenumber = false
    vim.opt_local.number = false
    vim.cmd('startinsert')
  end
})

vim.keymap.set('t', '<Esc>', '<C-\\><C-n>')
vim.keymap.set('n', '<A-t>', ':T<CR>')
vim.keymap.set('t', '<A-t>', '<C-\\><C-n>:q<CR>')
