local lspconfig = require("lspconfig")
local coq = require("coq")

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

local languages = {
  lua = {
    require("efmls-configs.formatters.stylua"),
  },
  nix = {
    { formatCommand = "nixfmt", formatStdin = true },
  },
}
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
}

for name, config in pairs(servers) do
  lspconfig[name].setup(coq.lsp_ensure_capabilities(config))
end

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(e)
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
    vim.keymap.set("n", "g]", function()
      vim.diagnostic.jump({ count = 1, float = true })
    end, { desc = "Goto next diagnostic (Neovim builtin)" })
    vim.keymap.set("n", "g[", function()
      vim.diagnostic.jump({ count = -1, float = true })
    end, { desc = "Goto previous diagnostic (Neovim builtin)" })

    local client = vim.lsp.get_client_by_id(e.data.client_id)
    if client ~= nil and client.supports_method("textDocument/formatting") then
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = e.bufnr,
        callback = function()
          vim.lsp.buf.format()
        end,
      })
    end
  end,
})
