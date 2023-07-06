vim.g['airline#extensions#default#layout'] = {
  { 'a', 'b', 'c' },
  { 'z' },
}

vim.g.airline_section_c = '%t %m'
vim.g.airline_section_z = (vim.g.airline_linecolumn_prefix or '') .. '%3l:%-2v'
vim.g['airline#extensions#hunks#non_zero_only'] = 1
vim.g['airline#extensions#tabline#fnamemod'] = ':t'
vim.g['airline#extensions#tabline#show_buffers'] = 1
vim.g['airline#extensions#tabline#show_splits'] = 0
vim.g['airline#extensions#tabline#show_tabs'] = 1
vim.g['airline#extensions#tabline#show_tab_nr'] = 0
vim.g['airline#extensions#tabline#show_tab_type'] = 1
vim.g['airline#extensions#tabline#show_close_button'] = 0

vim.g.airline_theme = 'tokyonight'
