vim.o.encoding = "utf-8"
vim.o.cmdheight = 1
vim.o.emoji = true
vim.o.number = true
vim.o.relativenumber = true
vim.o.signcolumn = "yes"
vim.o.clipboard = "unnamedplus,unnamed"
vim.o.expandtab = true
vim.o.shiftwidth = 2
vim.o.breakindent = true
vim.o.autoindent = true
vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    vim.o.formatoptions = "tcqnjp"
  end,
})
vim.o.swapfile = false
vim.o.undofile = true
vim.o.timeout = true
vim.o.timeoutlen = 300
vim.o.laststatus = 3
vim.g.mapleader = " "
vim.api.nvim_create_autocmd("BufWinEnter", {
  callback = function()
    if vim.bo.buftype == "help" then
      vim.cmd.wincmd("L")
    end
  end,
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "qf", "checkhealth" },
  callback = function()
    vim.opt_local.buflisted = false
  end,
})
vim.api.nvim_create_autocmd("BufLeave", {
  callback = function()
    if vim.bo.buftype == "quickfix" then
      vim.cmd.cclose()
    end
  end,
})
vim.keymap.set("ca", "wqa", "wa|qa")
