vim.keymap.set('n', '<C-n>', ':Fern . -reveal=% -drawer -toggle -width=40<CR>')

vim.api.nvim_create_augroup('glyph-palette', {})
vim.api.nvim_create_autocmd('FileType fern', {
  command = 'call glyph_palette#apply()',
  group = 'glyph-palette',
})
vim.api.nvim_create_autocmd('FileType nerdtree,startify', {
  command = 'call glyph_palette#apply()',
  group = 'glyph-palette',
})
