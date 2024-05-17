---@type LazySpec
return {
  'nvim-telescope/telescope.nvim',
  branch = '0.1.x',
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
    vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
    vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
    vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
    vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
    vim.keymap.set('n', '<leader>fk', builtin.keymaps, {})
    vim.keymap.set('n', '<leader>fc', builtin.colorscheme, {})
  end,
}
