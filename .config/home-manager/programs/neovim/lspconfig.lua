local lspconfig = require("lspconfig")

local servers = {}

servers.lua_ls = {
  settings = {
    Lua = {
      completion = {
        callSnipet = "Replace",
      },
    },
  },
}

servers.nil_ls = {}

servers.bashls = {}

local languages = {
  lua = {
    require("efmls-configs.formatters.stylua"),
  },
  nix = {
    require("efmls-configs.formatters.nixfmt"),
  },
  sh = {
    require("efmls-configs.formatters.beautysh"),
  },
}
local has_lsp_format, lsp_format = pcall(require, "lsp-format")
servers.efm = {
  filetypes = vim.tbl_keys(languages),
  init_options = {
    documentFormatting = true,
    documentRangeFormatting = true,
  },
  settings = {
    rootMarkers = { ".git/" },
    languages = languages,
  },
  on_attach = has_lsp_format and lsp_format.on_attach,
}

local has_coq, coq = pcall(require, "coq")
if has_coq then
  for name, config in pairs(servers) do
    servers[name] = coq.lsp_ensure_capabilities(config)
  end
end

for name, config in pairs(servers) do
  lspconfig[name].setup(config)
end

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function()
    vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "Jump to the references (Neovim builtin)" })
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Jump to the definition (Neovim builtin)" })
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Jump to the declaration (Neovim builtin)" })
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "Jump to the implementation (Neovim builtin)" })
    vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, { desc = "Jump to the type definition (Neovim builtin)" })
    vim.keymap.set("n", "gf", vim.lsp.buf.format, { desc = "Format current file (Neovim builtin)" })
    vim.keymap.set("n", "gn", vim.lsp.buf.rename, { desc = "Rename symbol under cursor (Neovim builtin)" })
    vim.keymap.set("n", "g.", vim.lsp.buf.code_action, { desc = "Do code action under cursor (Neovim builtin)" })
    vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover on symbol under cursor (Neovim builtin)" })
    vim.keymap.set("n", "ge", vim.diagnostic.open_float, { desc = "Open diagnostic float (Neovim builtin)" })
    vim.keymap.set("n", "g]", vim.diagnostic.goto_next, { desc = "Goto next diagnostic (Neovim builtin)" })
    vim.keymap.set("n", "g[", vim.diagnostic.goto_prev, { desc = "Goto previous diagnostic (Neovim builtin)" })
  end,
})
