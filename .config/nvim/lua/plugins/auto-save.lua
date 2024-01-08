return {
  'pocco81/auto-save.nvim',
  event = { 'InsertLeave', 'BufLeave', 'FocusLost' },
  config = function()
    require 'auto-save'.setup({
      trigger_events = { 'InsertLeave', 'BufLeave', 'FocusLost' },
    })
  end
}
