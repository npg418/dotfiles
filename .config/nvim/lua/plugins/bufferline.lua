---@type LazySpec
return {
  'akinsho/bufferline.nvim',
  version = '*',
  event = 'VimEnter',
  dependencies = 'nvim-tree/nvim-web-devicons',
  ---@type bufferline.UserConfig
  opts = {
    options = {
      indicator = {
        style = 'none',
      },
      diagnostics = 'nvim_lsp',
      show_buffer_close_icons = false,
      separator_style = { '', '' },
    },
  },
}
