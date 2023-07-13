local on_attach = function()
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

require('mason').setup()

local lspconfig = require('lspconfig')
require('mason-lspconfig').setup()
require('mason-lspconfig').setup_handlers {
  function(server_name)
    local opt = {
      on_attach = on_attach,
      capabilities = capabilities,
    }
    local node_root_dir = lspconfig.util.root_pattern("package.json")
    local is_node_repo = node_root_dir(vim.api.nvim_buf_get_name(0)) ~= nil

    if server_name == "tsserver" then
      if not is_node_repo then
        return
      end

      opt.root_dir = node_root_dir
    elseif server_name == "eslint" then
      if not is_node_repo then
        return
      end

      opt.root_dir = node_root_dir
    elseif server_name == "denols" then
      if is_node_repo then
        return
      end

      opt.root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc", "deps.ts", "import_map.json")
      opt.init_options = {
        lint = true,
        unstable = true,
        suggest = {
          imports = {
            hosts = {
              ["https://deno.land"] = true,
              ["https://cdn.nest.land"] = true,
              ["https://crux.land"] = true
            }
          }
        }
      }
    end
    lspconfig[server_name].setup(opt)
  end,
}
