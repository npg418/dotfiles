return {
  'lambdalisue/fern.vim',
  keys = {
    { '<C-n>', '<cmd>Fern . -reveal=% -drawer -toggle -width=40<CR>', desc = 'toggle [F]ern' },
  },
  dependencies = {
    { 'lambdalisue/nerdfont.vim' },
    {
      'lambdalisue/fern-renderer-nerdfont.vim',
      config = function()
        vim.g['fern#renderer'] = 'nerdfont'
      end,
    },
    {
      'lambdalisue/glyph-palette.vim',
      config = function()
        vim.cmd [[
          augroup my-glyph-palette
            autocmd! *
            autocmd FileType fern call glyph_palette#apply()
            autocmd FileType nerdtree,startify call glyph_palette#apply()
          augroup end
        ]]
      end,
    },
  },
}
