---@type LazySpec
return {
  'pocco81/auto-save.nvim',
  event = { 'FocusLost', 'BufLeave' },
  enabled = false,
  opts = {
    trigger_events = { 'FocusLost', 'BufLeave' },
    condition = function()
      return vim.fn.filereadable(vim.fn.expand('%')) == 1
    end,
  },
}
