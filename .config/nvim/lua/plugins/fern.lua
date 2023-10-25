return {
  'lambdalisue/fern.vim',
  keys = {
    { '<C-n>', '<cmd>Fern . -reveal=% -drawer -toggle -width=40<CR>', desc = 'toggle [F]ern' },
  },
  dependencies = {
    'lambdalisue/nerdfont.vim',
    {
      'lambdalisue/fern-renderer-nerdfont.vim',
      config = function()
        vim.g['fern#renderer'] = 'nerdfont'
      end,
    },
    {
      'lambdalisue/glyph-palette.vim',
      config = function()
        vim.api.nvim_create_augroup('glyph-palette', {})
        vim.api.nvim_create_autocmd('FileType', {
          pattern = 'fern',
          group = 'glyph-palette',
          callback = function ()
            vim.fn['glyph_palette#apply']()
          end
        })
      end,
    },
    {
      'yuki-yano/fern-preview.vim',
      config = function()
        vim.api.nvim_create_augroup('quicklook', {})
        vim.api.nvim_create_autocmd('FileType', {
          pattern = 'fern',
          group = 'quicklook',
          callback = function()
            local function set(keys, command)
              vim.keymap.set('n', keys, '<Plug>(fern-action-preview:' .. command .. ')',
                { remap = true, buffer = true, silent = true }
              )
            end
            set('<SPACE>', 'toggle')
            set('<C-u>', 'scroll:up:half')
            set('<C-d>', 'scroll:down:half')
          end
        })
      end
    },
  },
}
