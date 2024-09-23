---@type LazySpec
return {
  'nvim-telescope/telescope.nvim',
  branch = '0.1.x',
  cmd = 'Telescope',
  keys = {
    '<leader>ff',
    '<leader>fg',
    '<leader>fb',
    '<leader>fh',
    '<leader>fk',
    '<leader>fc',
  },
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    require('telescope').setup({
      pickers = {
        colorscheme = {
          enable_preview = true,
        },
      },
    })
    vim.api.nvim_create_autocmd('VimLeave', {
      callback = function()
        local file = io.open(vim.fn.stdpath('config') .. '/lua/generated/colorscheme.lua', 'w')
        if file then
          file:write("vim.cmd.colorscheme('" .. vim.g.colors_name .. "')")
          file:close()
        end
      end,
    })
    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Open file finder (telescope)' })
    vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Open live grep (telescope)' })
    vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Open buffer swicher (telescope)' })
    vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Open help tags viewer (telescope)' })
    vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = 'Open keymaps viwer (telescope)' })
    vim.keymap.set('n', '<leader>fc', builtin.colorscheme, { desc = 'Open colorscheme switcher (telescope)' })
  end,
}
