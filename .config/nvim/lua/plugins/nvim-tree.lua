return {
  'nvim-tree/nvim-tree.lua',
  keys = {
    { '<C-n>', '<CMD>NvimTreeOpen<CR>', mode = 'n' }
  },
  config = function()
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    vim.opt.termguicolors = true

    require('nvim-tree').setup()
  end
}
