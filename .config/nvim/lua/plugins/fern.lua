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
      end,
    },
  },
}

