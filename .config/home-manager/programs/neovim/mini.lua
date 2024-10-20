local modules = {
  "ai",
  "align",
  "animate",
  "basics",
  "bracketed",
  "bufremove",
  "clue",
  "colors",
  "comment",
  "completion",
  "cursorword",
  "diff",
  "extra",
  "files",
  "git",
  "hipatterns",
  "indentscope",
  "icons",
  "jump",
  "map",
  "misc",
  "move",
  "notify",
  "pairs",
  "pick",
  "sessions",
  "splitjoin",
  "starter",
  "statusline",
  "surround",
  "tabline",
  "trailspace",
  "visits",
}
for _, module in ipairs(modules) do
  require("mini." .. module).setup()
end

vim.keymap.set("n", "<Leader>bd", MiniBufremove.delete, { desc = "Delete current buffer (mini.bufremove)" })
vim.keymap.set("n", "<Leader>db", function()
  vim.cmd("b#")
  vim.opt_local.buflisted = true
end, { desc = "Restore deleted buffer (mini.bufremove)" })

MiniClue.setup({
  triggers = {
    { mode = "n", keys = "<Leader>" },
    { mode = "x", keys = "<Leader>" },

    { mode = "n", keys = "g" },
    { mode = "x", keys = "g" },

    { mode = "n", keys = "'" },
    { mode = "n", keys = "`" },
    { mode = "x", keys = "'" },
    { mode = "x", keys = "`" },

    { mode = "n", keys = '"' },
    { mode = "x", keys = '"' },
    { mode = "i", keys = "<C-r>" },
    { mode = "c", keys = "<C-r>" },

    { mode = "n", keys = "<C-w>" },

    { mode = "n", keys = "z" },
    { mode = "x", keys = "z" },

    { mode = "n", keys = "s" },
    { mode = "x", keys = "s" },
  },
  clues = {
    MiniClue.gen_clues.builtin_completion(),
    MiniClue.gen_clues.g(),
    MiniClue.gen_clues.marks(),
    MiniClue.gen_clues.registers(),
    MiniClue.gen_clues.windows(),
    MiniClue.gen_clues.z(),
  },
  delay = 200,
})

MiniCompletion.setup({
  fallback_action = function()
    if vim.api.nvim_get_option_value("omnifunc", {}) == "" then
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-x><C-k>", true, true, true), "n", false)
    else
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-x><C-o>", true, true, true), "n", false)
    end
  end,
})
vim.keymap.set(
  "i",
  "<Tab>",
  [[pumvisible() ? "\<C-n>" : "<Tab>"]],
  { expr = true, desc = "Select next candidate (mini.completion)" }
)
vim.keymap.set(
  "i",
  "<S-Tab>",
  [[pumvisible() ? "\<C-p>" : "<Tab>"]],
  { expr = true, desc = "Select previous candidate (mini.completion)" }
)
vim.keymap.set("i", "<CR>", function()
  if vim.fn.pumvisible() == 0 then
    return MiniPairs.cr()
  elseif vim.fn.complete_info()["selected"] ~= -1 then
    return vim.api.nvim_replace_termcodes("<C-y>", true, true, true)
  else
    return vim.api.nvim_replace_termcodes("<C-y><CR>", true, true, true)
  end
end, { expr = true, desc = "Confirm candidate (mini.completion)" })

vim.keymap.set("n", "<C-n>", MiniFiles.open, { desc = "Open file explorer (mini.files)" })

MiniHipatterns.setup({
  highlighters = {
    fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
    hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
    todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
    note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },

    hex_color = MiniHipatterns.gen_highlighter.hex_color(),
  },
})

MiniMap.setup({
  symbols = {
    encode = MiniMap.gen_encode_symbols.dot("4x2"),
  },
  window = {
    width = 20,
  },
  integrations = {
    MiniMap.gen_integration.diagnostic({
      error = "DiagnosticFloatingError",
      warn = "DiagnosticFloatingWarn",
      info = "DiagnosticFloatingInfo",
      hint = "DiagnosticFloatingHint",
    }),
  },
})
vim.api.nvim_create_autocmd("VimEnter", {
  once = true,
  callback = MiniMap.open,
})

MiniNotify.setup()
vim.notify = MiniNotify.make_notify()

MiniSessions.setup({
  autoread = true,
  autowrite = true,
})

vim.ui.select = MiniPick.ui_select

-- tabline setup reference: https://github.com/debugloop/dotfiles/blob/main/home/nvim/lua/plugins.lua#L889
MiniTabline.setup({
  format = function(buf_id, label)
    local suffix = ""
    if vim.bo[buf_id].modified then
      suffix = "● "
    elseif vim.bo[buf_id].readonly then
      suffix = " "
    end
    return MiniTabline.default_format(buf_id, label) .. suffix
  end,
})
