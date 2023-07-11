vim.api.nvim_create_augroup('terminal_mode', {})

local function save_mode()
  vim.b.term_mode = vim.fn.mode()
end

vim.api.nvim_create_autocmd('TermEnter term://*', {
  group = 'terminal_mode',
  callback = save_mode
})

vim.api.nvim_create_autocmd('TermLeave term://*', {
  group = 'terminal_mode',
  callback = 'terminal_mode'
})

vim.api.nvim_create_autocmd('BufEnter term://*', {
  group = 'terminal_mode',
  callback = function()
    if vim.b.term_mode == 't' then
      vim.cmd('startinsert')
    end
  end
})
