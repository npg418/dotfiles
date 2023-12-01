return {
  'neovim/nvim-lspconfig',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    {
      'williamboman/mason-lspconfig.nvim',
      dependencies = {
        'williamboman/mason.nvim',
        'folke/neodev.nvim',
      },
      config = function()
        require('mason').setup()
        require('neodev').setup()
        local mason_lspconfig = require('mason-lspconfig')
        local lspconfig = require('lspconfig')

        local function is_node()
          local root = lspconfig.util.root_pattern('package.json')
          return root(vim.api.nvim_buf_get_name(0)) ~= nil
        end

        local handlers = {
          function(server)
            lspconfig[server].setup({
              capabilities = require('cmp_nvim_lsp').default_capabilities(),
              on_attach = function(_, bufnr)
                vim.api.nvim_create_augroup('lsp', {})
                vim.api.nvim_create_autocmd('BufWritePre', {
                  buffer = bufnr,
                  callback = function()
                    vim.lsp.buf.format { async = true }
                  end,
                  group = 'lsp',
                })
              end,
            })
          end,
          lua_ls = function()
            lspconfig.lua_ls.setup({
              settings = {
                Lua = {
                  diagnostics = {
                    globals = { 'vim' },
                  },
                  completion = {
                    callSnippet = 'Replace',
                  },
                  workspace = {
                    checkThirdParty = false,
                  },
                  telemetry = { enabled = false },
                },
                capabilities = require('cmp_nvim_lsp').default_capabilities(),
              }
            })
          end,
          powershell_es = function()
            lspconfig.powershell_es.setup({
              bundle_path = vim.fn.stdpath('data') .. '/mason/packages/powershell-editor-services',
            })
          end,
          denols = function()
            if not is_node() then
              lspconfig.denols.setup({
                root_dir = lspconfig.util.root_pattern('deno.json', 'deno.jsonc'),
              })
            end
          end,
          tsserver = function()
            if is_node() then
              lspconfig.tsserver.setup({
                root_dir = lspconfig.util.root_pattern('package.json', 'tsconfig.json', 'node_modules'),
              })
            end
          end,
        }
        mason_lspconfig.setup_handlers(handlers)
      end,
    },
  },
  config = function()
    local set = vim.keymap.set
    set('n', 'K', vim.lsp.buf.hover)
    set('n', 'gf', function() vim.lsp.buf.format { async = true } end)
    set('n', 'gr', vim.lsp.buf.references)
    set('n', 'gd', vim.lsp.buf.definition)
    set('n', 'gD', vim.lsp.buf.declaration)
    set('n', 'gi', vim.lsp.buf.implementation)
    set('n', 'gt', vim.lsp.buf.type_definition)
    set('n', '<space>rn', vim.lsp.buf.rename)
    set('n', 'ge', vim.diagnostic.open_float)
    set('n', 'g]', vim.diagnostic.goto_next)
    set('n', 'g[', vim.diagnostic.goto_prev)
    set('n', 'ga', vim.lsp.buf.code_action)

    vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics,
      { virtual_text = true })

    vim.cmd [[
      set updatetime=500
      highlight LspReferenceText cterm=underline ctermfg=1 ctermbg=8 gui=underline guifg=#A00000 guibg=#104040
      highlight LspReferenceRead cterm=underline ctermfg=1 ctermbg=8 gui=underline guifg=#A00000 guibg=#104040
      highlight LspReferenceWrite cterm=underline ctermfg=1 ctermbg=8 gui=underline guifg=#A00000 guibg=#104040
      ]]
  end,
}
