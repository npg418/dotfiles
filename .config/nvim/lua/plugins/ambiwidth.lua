---@type LazySpec
return {
  'rbtnn/vim-ambiwidth',
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    vim.fn.setcellwidths({
      { 0x276F, 0x276F, 1 },
    })
  end,
}

-- 😏👍
