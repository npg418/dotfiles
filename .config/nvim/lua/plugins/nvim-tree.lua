return {
  'nvim-tree/nvim-tree.lua',
  enabled = false,
  keys = {
    { '<C-n>', '<cmd>NvimTreeToggle<CR>', mode = 'n' }
  },
  config = function()
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    vim.opt.termguicolors = true

    require('nvim-tree').setup({
      filters = {
        git_ignored = false,
        custom = {
          '^\\.git',
          '^node_modules'
        }
      },
      renderer = {
        indent_markers = {
          enable = true
        },
        icons = {
          git_placement = 'after'
        }
      },
      on_attach = function(bufnr)
        local api = require('nvim-tree.api')
        local function opts(desc)
          return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end
        api.config.mappings.default_on_attach(bufnr)
        vim.keymap.set('n', 'l', api.node.open.edit, opts('Edit Or Open'))
        vim.keymap.set('n', 'L', api.node.open.vertical, opts('Open in split'))
        vim.keymap.set('n', 'h', api.node.navigate.parent_close, opts('Collapse'))
        vim.keymap.set('n', 'H', api.tree.collapse_all, opts('Collapse All'))
        vim.keymap.set('n', '?', api.tree.toggle_help, opts('Help'))
      end,
    })
  end
}
