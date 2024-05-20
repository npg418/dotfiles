---@param name string
---@param opt LazyPluginSpec | nil
---@return LazyPluginSpec
local function mini_module(name, opt)
  return vim.tbl_extend('keep', {
    'echasnovski/mini.' .. name,
    config = opt and opt.config or function()
      require('mini.' .. name).setup()
    end,
  }, opt)
end

return {
  mini_module('indentscope', {
    event = 'VimEnter',
    enabled = false,
    config = function()
      require('mini.indentscope').setup()
      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'alpha,neo-tree',
        callback = function()
          ---@diagnostic disable-next-line: inject-field
          vim.b.miniindentscope_disable = true
        end,
      })
      vim.api.nvim_create_autocmd('TermOpen', {
        callback = function()
          ---@diagnostic disable-next-line: inject-field
          vim.b.miniindentscope_disable = true
        end,
      })
    end,
  }),
  mini_module('comment', {
    keys = {
      { 'gcc', mode = 'n' },
      { 'gc', mode = { 'n', 'v' } },
    },
  }),
  mini_module('pairs', {
    event = 'InsertEnter',
  }),
  mini_module('splitjoin', {
    keys = 'gS',
  }),
  mini_module('bufremove', {
    keys = '<C-w>',
    config = function()
      require('mini.bufremove').setup()
      vim.keymap.set('n', '<C-q>', '<C-w>')
      vim.keymap.set('n', '<C-w>', MiniBufremove.wipeout)
    end,
  }),
  mini_module('trailspace', {
    event = 'VeryLazy',
  }),
  mini_module('jump', {
    keys = {
      { 'f', mode = { 'n', 'v' } },
      { 'F', mode = { 'n', 'v' } },
      { 't', mode = { 'n', 'v' } },
      { 'T', mode = { 'n', 'v' } },
      ';',
    },
  }),
  mini_module('surround', {
    keys = {
      { 'sa', mode = { 'n', 'v' } },
      'sd',
      'sf',
      'sF',
      'sh',
      'sr',
      'sn',
    },
  }),
  mini_module('statusline', {
    lazy = false,
    config = function()
      require('mini.statusline').setup({
        content = {
          active = function()
            local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
            local git = MiniStatusline.section_git({ trunc_width = 75 })
            local diagnostics = MiniStatusline.section_diagnostics({ trunc_width = 75 })
            local fileinfo = MiniStatusline.section_fileinfo({ trunc_width = 120 })

            local filename = function()
              if vim.bo.buftype == 'terminal' then
                return '%t'
              else
                return '%f%m%r'
              end
            end

            return MiniStatusline.combine_groups({
              { hl = mode_hl, strings = { mode } },
              { hl = 'MiniStatuslineDevinfo', strings = { git, diagnostics } },
              '%<',
              { hl = 'MiniStatuslineFilename', strings = { filename() } },
              '%=',
              { hl = 'MiniStatuslineFileinfo', strings = { fileinfo } },
              { hl = mode_hl, strings = { 'L%l' } },
            })
          end,
          inactive = function()
            local filename = function()
              if vim.bo.buftype == 'terminal' then
                return '%t'
              else
                return '%f%m%r'
              end
            end

            return MiniStatusline.combine_groups({
              '%=',
              { hl = 'MiniStatuslineFilename', strings = { filename() } },
            })
          end,
        },
        use_icons = true,
        set_vim_setting = false,
      })
      vim.o.laststatus = 3
      vim.o.showmode = false
    end,
  }),
}
