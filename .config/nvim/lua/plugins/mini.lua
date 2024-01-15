return {
  'echasnovski/mini.nvim',
  version = false,
  lazy = false,
  config = function()
    vim.api.nvim_create_autocmd('InsertEnter', {
      once = true,
      callback = function()
        require 'mini.ai'.setup()
        require 'mini.comment'.setup()
        require 'mini.splitjoin'.setup()
        require 'mini.pairs'.setup()
        require 'mini.surround'.setup()
      end
    })

    vim.api.nvim_create_autocmd('VimEnter', {
      once = true,
      callback = function()
        require 'mini.indentscope'.setup()
        require 'mini.animate'.setup()
        require 'mini.bufremove'.setup()
        vim.keymap.set('n', '<C-w>', MiniBufremove.wipeout)
        require 'mini.tabline'.setup()
        require 'mini.trailspace'.setup()
      end
    })

    require 'mini.statusline'.setup({
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
            { hl = mode_hl,                 strings = { mode } },
            { hl = 'MiniStatuslineDevinfo', strings = { git, diagnostics } },
            '%<',
            { hl = 'MiniStatuslineFilename', strings = { filename() } },
            '%=',
            { hl = 'MiniStatuslineFileinfo', strings = { fileinfo } },
            { hl = mode_hl,                  strings = { 'L%l' } },
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
      set_vim_setting = false
    })
    vim.o.laststatus = 3
  end
}
