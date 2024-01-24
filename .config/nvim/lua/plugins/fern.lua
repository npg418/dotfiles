return {
  'lambdalisue/fern.vim',
  enabled = false,
  keys = {
    { '<C-n>', '<cmd>Fern . -reveal=% -drawer -toggle -width=30<CR>' },
  },
  config = function ()
    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'fern',
      callback = function ()
        vim.opt_local.number = false
        vim.opt_local.relativenumber = false
      end
    })
  end,
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
        vim.api.nvim_create_autocmd('FileType', {
          pattern = 'fern',
          callback = function ()
            vim.fn['glyph_palette#apply']()
          end
        })
      end,
    },
    {
      'yuki-yano/fern-preview.vim',
      config = function()
        vim.api.nvim_create_autocmd('FileType', {
          pattern = 'fern',
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
