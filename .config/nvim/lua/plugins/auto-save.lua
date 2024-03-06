return {
  'pocco81/auto-save.nvim',
  event = { 'BufLeave', 'FocusLost' },
  config = function()
    require('auto-save').setup({
      trigger_events = { 'BufLeave', 'FocusLost' },
    })
  end,
}
