---@type LazySpec
return {
  'lukas-reineke/indent-blankline.nvim',
  main = 'ibl',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    'HiPhish/rainbow-delimiters.nvim',
  },
  config = function()
    local rainbow = {
      RainbowRed = '#E06C75',
      RainbowYellow = '#E5C07B',
      RainbowBlue = '#61AFEF',
      RainbowOrange = '#D19A66',
      RainbowGreen = '#98C379',
      RainbowViolet = '#C678DD',
      RainbowCyan = '#56B6C2',
    }

    local hooks = require('ibl.hooks')
    hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
      for hl, color in pairs(rainbow) do
        vim.api.nvim_set_hl(0, hl, { fg = color })
      end
      vim.api.nvim_set_hl(0, 'IblScope', { fg = '#ffffff' })
    end)

    vim.g.rainbow_delimiters = { highlight = vim.tbl_keys(rainbow) }

    require('ibl').setup({
      scope = { show_start = false },
      indent = { highlight = vim.tbl_keys(rainbow) },
    })

    hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
  end,
}
