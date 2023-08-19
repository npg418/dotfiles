local AA = {
  [[          /＾>》, -―‐‐＜＾}]],
  [[         ./:::/,≠´::::::ヽ.]],
  [[        /::::〃::::／}::丿ハ]],
  [[      ./:::::i{ |／  ﾉ／ }::}]],
  [[     /:::::::瓜  ＞  ´＜ ,:ﾉ]],
  [[   ./::::::|ﾉﾍ.{､  (_ﾌ_ノﾉイ＿]],
  [[   |:::::::|／}｀ｽ /          /]],
  [[.  |::::::|(_:::つ/    FMV   /  neovim!]],
  [[.￣￣￣￣￣￣￣＼/＿＿＿＿＿/￣￣￣￣￣]],
}


local function button(sc, txt, keybind)
  local sc_ = sc:gsub('%s', ''):gsub('SPC', '<leader>')
  local opts = {
    position = 'center',
    text = txt,
    shortcut = sc,
    cursor = 6,
    width = 19,
    align_shortcut = 'right',
    hl_shortcut = 'Number',
    hl = 'Function',
  }
  if keybind then
    opts.keymap = { 'n', sc_, keybind, { noremap = true, silent = true } }
  end
  return {
    type = 'button',
    val = txt,
    on_press = function()
      local key = vim.api.nvim_replace_termcodes(sc_, true, false, true)
      vim.api.nvim_feedkeys(key, 'normal', false)
    end,
    opts = opts,
  }
end

return {
  'goolord/alpha-nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  event = 'VimEnter',
  config = function ()
    local header = {
      type = 'text',
      val = AA,
      opts = {
        position = 'center',
        hl = 'Comment',
      },
    }
    local message = {
      type = 'text',
      val = { 'へいよーぐっづすっす' },
      opts = {
        position = 'center',
        hl = 'Text',
      },
    }
    local buttons = {
      type = 'group',
      val = {
        button('e', '  New', ':ene<CR>'),
        button('c', '  Config', ':e ' .. vim.fn.stdpath('config') .. '/init.lua | :cd %:p:h | pwd<CR>'),
        button('q', '  Quit', ':qa<CR>'),
      },
      opts = {
        position = 'center',
        spacing = 1,
      },
    }
    local opts = {
      layout = {
        { type = 'padding', val = function() return math.floor(vim.o.lines * 0.25) end },
        header,
        { type = 'padding', val = 1 },
        message,
        { type = 'padding', val = 2 },
        buttons,
        {
          type = 'text',
          val = {},
          opts = {
            position = 'center',
            hl = 'Comment',
          },
        },
      },
      opts = {},
    }
    require'alpha'.setup(opts)
  end
}
