---@type LazySpec
return {
  'lukas-reineke/indent-blankline.nvim',
  main = 'ibl',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    'HiPhish/rainbow-delimiters.nvim',
  },
  config = function()
    local highlight = {
      RainbowRed = '#b33f48',
      RainbowYellow = '#b8934e',
      RainbowBlue = '#3482c2',
      RainbowGreen = '#6b964c',
      RainbowViolet = '#994bb0',
      RainbowCyan = '#298995',
    }

    local hooks = require('ibl.hooks')
    hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
      for hl, color in pairs(highlight) do
        vim.api.nvim_set_hl(0, hl, { fg = color })
      end
    end)

    vim.g.rainbow_delimiters = { highlight = vim.tbl_keys(highlight) }

    require('ibl').setup({
      scope = {
        show_start = false,
      },
      indent = {
        highlight = vim.tbl_keys(highlight)
      },
    })

    hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
  end,
}
