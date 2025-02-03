require("lsp-format").setup({})

vim.keymap.set("ca", "wq", [[execute "Format sync" <bar> wq]])
