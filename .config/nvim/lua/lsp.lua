local on_attach = function(_, _)
  local set = vim.keymap.set
  set('n', 'gd', vim.lsp.buf.definition)
  set('n', 'K', vim.lsp.buf.hover)
  set('n', '<C-m>', vim.lsp.buf.signature_help)
  set('n', 'gy', vim.lsp.buf.type_definition)
  set('n', 'rn', vim.lsp.buf.rename)
  set('n', 'ma', vim.lsp.buf.code_action)
  set('n', 'gr', vim.lsp.buf.references)
  set('n', '<S-A-f>', vim.lsp.buf.format)
  set('n', '<space>e', vim.lsp.diagnostic.show_line_diagnostics)
  set('n', '[d', vim.lsp.diagnostic.goto_prev)
  set('n', ']d', vim.lsp.diagnostic.goto_next)
end

local capabilities = require('cmp_nvim_lsp').default_capabilities()

local lsp_settings = {
  sumneko_lua = {
    Lua = {
      diagnostics = {
        globals = { 'vim' }
      }
    }
  },
}

require('mason').setup()
require('mason-lspconfig').setup()
require('mason-lspconfig').setup_handlers {
  function(server_name)
    require('lspconfig')[server_name].setup {
      on_attach = on_attach,
      capabilities = capabilities,
      settings = lsp_settings[server_name],
    }
  end,
}
