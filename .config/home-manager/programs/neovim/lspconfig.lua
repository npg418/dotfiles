local lspconfig = require("lspconfig")

lspconfig.lua_ls.setup({
  settings = {
    Lua = {
      completion = {
        callSnipet = "Replace",
      },
    },
  },
})

lspconfig.nil_ls.setup({})

local languages = {
  lua = {
    require("efmls-configs.formatters.stylua"),
  },
  nix = {
    { formatCommand = "nixfmt", formatStdin = true },
  },
}
lspconfig.efm.setup({
  filetypes = vim.tbl_keys(languages),
  init_options = {
    documentFormatting = true,
    documentRangeFormatting = true,
  },
  settings = {
    rootMarkers = { ".git/" },
    languages = languages,
  },
})

local augroup = vim.api.nvim_create_augroup("lsp", {})
vim.api.nvim_create_autocmd("LspAttach", {
  group = augroup,
  callback = function(e)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "Jump on the references (Neovim builtin)" })
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Jump on the definition (Neovim builtin)" })
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Jump on the declaration (Neovim builtin)" })
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "Jump on the implementation (Neovim builtin)" })
    vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, { desc = "Jump on the type definition (Neovim builtin)" })
    vim.keymap.set("n", "gf", vim.lsp.buf.format, { desc = "Format current file (Neovim builtin)" })
    vim.keymap.set("n", "gn", vim.lsp.buf.rename, { desc = "Rename symbol under cursor (Neovim builtin)" })
    vim.keymap.set("n", "g.", vim.lsp.buf.code_action, { desc = "Do code action under cursor (Neovim builtin)" })
    vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover on symbol under cursor (Neovim builtin)" })
    vim.keymap.set("n", "ge", vim.diagnostic.open_float, { desc = "Open diagnostic float (Neovim builtin)" })
    vim.keymap.set("n", "g]", function()
      vim.diagnostic.jump({ count = 1, float = true })
    end, { desc = "Goto next diagnostic (Neovim builtin)" })
    vim.keymap.set("n", "g[", function()
      vim.diagnostic.jump({ count = -1, float = true })
    end, { desc = "Goto previous diagnostic (Neovim builtin)" })

    local client = vim.lsp.get_client_by_id(e.data.client_id)
    if client ~= nil and client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = e.bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = e.bufnr,
        callback = vim.lsp.buf.format,
      })
    end
  end,
})
