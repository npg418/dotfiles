return {
  'neovim/nvim-lspconfig',
  event = { 'BufReadPre', 'BufNewFile' },
  depedencies = {
    {
      'lvimuser/lsp-inlayhints.nvim',
      event = 'Verylazy',
      config = function()
        vim.api.nvim_create_augroup('LspAttach_inlayhints', {})
        vim.api.nvim_create_autocmd('LspAttach', {
          group = 'LspAttach_inlayhints',
          callback = function(args)
            if not (args.data and args.data.client_id) then
              return
            end
            local bufnr = args.buf
            local client = vim.lsp.get_client_by_id(args.data.client_id)
            require('lsp-inlayhints').on_attach(client, bufnr)
          end,
        })
        require('lsp-inlayhints').setup()
      end,
    },
    {
      'williamboman/mason-lspconfig.nvim',
      dependencies = {
        'williamboman/mason.nvim',
        'lukas-reineke/lsp-format.nvim',
      },
      config = function()
        require('mason').setup()
        local mason_lspconfig = require('mason-lspconfig')

        local handlers = {
          function(server)
            require('lspconfig')[server].setup({
              capabilities = require('cmp_nvim_lsp').default_capabilities(),
            })
          end,
          ['lua_ls'] = function()
            local on_attach = function(client)
              require('lsp-format').on_attach(client)
            end
            require('lspconfig').lua_ls.setup({
              on_attach = on_attach,
              settings = {
                Lua = {
                  runtime = {
                    version = 'LuaJIT',
                    path = vim.split(package.path, ';'),
                  },
                  diagnostics = {
                    globals = { 'vim' },
                  },
                  workspace = {
                    library = {
                      [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                      [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
                    },
                  },
                },
              }
            })
          end,
        }
        mason_lspconfig.setup()
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

      vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, { virtual_text = true })
      
      vim.cmd[[
      set updatetime=500
      highlight LspReferenceText cterm=underline ctermfg=1 ctermbg=8 gui=underline guifg=#A00000 guibg=#104040
      highlight LspReferenceRead cterm=underline ctermfg=1 ctermbg=8 gui=underline guifg=#A00000 guibg=#104040
      highlight LspReferenceWrite cterm=underline ctermfg=1 ctermbg=8 gui=underline guifg=#A00000 guibg=#104040
      ]]
    end,
}