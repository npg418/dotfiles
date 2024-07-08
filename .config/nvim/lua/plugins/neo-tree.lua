return {
  'nvim-neo-tree/neo-tree.nvim',
  enabled = false,
  branch = 'v3.x',
  keys = {
    { '<C-n>', '<cmd>Neotree toggle reveal<CR>' },
    { '<C-g>', '<cmd>Neotree float git_status<CR>' },
  },
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    'MunifTanjim/nui.nvim',
    '3rd/image.nvim',
  },
  config = function()
    require('neo-tree').setup({
      close_if_last_window = true,
      default_component_configs = {
        git_status = {
          -- added = 'A',
          -- deleted = 'D',
          -- modified = 'M',
          -- renamed = 'RN',
          -- untracked = 'U',
          -- ignored = 'IG',
          -- unstaged = 'US',
          -- staged = 'S',
          -- conflict = 'C',
        },
      },
      filesystem = {
        window = {
          width = 30,
          mappings = {
            l = 'open',
            L = 'open_vsplit',
            h = 'close_node',
            H = 'navigate_up',
            ['!'] = 'toggle_hidden',
          },
        },
        filtered_items = {
          hide_gitignored = false,
          hide_by_name = {
            'node_modules',
          },
        },
      },
    })
  end,
}
