require("toggleterm").setup({
  size = 100,
  open_mapping = "<C-t>",
  hide_numbers = true,
  shade_filetypes = {},
  shade_terminals = true,
  shading_factor = 2,
  start_in_insert = true,
  insert_mappings = true,
  persist_size = true,
  direction = "float",
  close_on_exit = true,
  on_create = function()
    vim.b.miniindentscope_disable = true
  end,
})

vim.api.nvim_create_autocmd("TermEnter", {
  callback = function()
    vim.cmd.wall()
  end,
})
