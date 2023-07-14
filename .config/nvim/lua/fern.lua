vim.keymap.set('n', '<C-n>', ':Fern . -reveal=% -drawer -toggle -width=40<CR>')

vim.api.nvim_create_augroup('fern-config', {})
vim.api.nvim_create_autocmd('FileType fern', {
  group = 'fern-config',
  callback = function()
    vim.call('glyph_palette#apply')
    local opt = { silent = true, buffer = true, remap = true }
    vim.keymap.set('n', 'p', '<Plug>(fern-action-preview:toggle)', opt)
    vim.keymap.set('n', '<C-p>', '<Plug>(fern-action-preview:auto:toggle)', opt)
    vim.keymap.set('n', '<C-d>', '<Plug>(fern-action-preview:scroll:down:half)', opt)
    vim.keymap.set('n', '<C-u>', '<Plug>(fern-action-preview:scroll:up:half)', opt)
  end
})
vim.api.nvim_create_autocmd("WinEnter", {
  callback = function()
    if (vim.bo.filetype ~= "fern") then
      vim.cmd("FernDo close -stay")
    end
  end,
  group = 'fern-config'
})
