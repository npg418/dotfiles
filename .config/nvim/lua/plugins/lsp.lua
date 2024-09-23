---@type LazySpec
return {
  {
    'williamboman/mason.nvim',
    cmd = {
      'Mason',
      'MasonInstall',
      'MasonUninstall',
      'MasonUninstallAll',
      'MasonLog',
      'MasonUpdate',
    },
    ---@type MasonSettings
    opts = {
      ui = {
        icons = {
          package_installed = '✓',
          package_uninstalled = '✗',
          package_pending = '⟳',
        },
        border = 'single',
      },
    },
    build = ':MasonUpdate',
  },
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    keys = {
      { 'K',  vim.lsp.buf.hover },
      { 'gf', vim.lsp.buf.format },
      { 'gr', vim.lsp.buf.references },
      { 'gd', vim.lsp.buf.definition },
      { 'gD', vim.lsp.buf.declaration },
      { 'gi', vim.lsp.buf.implementation },
      { 'gt', vim.lsp.buf.type_definition },
      { 'gn', vim.lsp.buf.rename },
      { 'ge', vim.diagnostic.open_float },
      { 'g]', vim.diagnostic.goto_next },
      { 'g[', vim.diagnostic.goto_prev },
      { 'ga', vim.lsp.buf.code_action },
    },
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'folke/neodev.nvim',
    },
    config = function()
      require('neodev').setup()
      local lspconfig = require('lspconfig')
      local mason_lspconfig = require('mason-lspconfig')

      mason_lspconfig.setup({
        ensure_installed = { 'lua_ls' },
      })
      local function is_deno()
        local root = lspconfig.util.root_pattern('deno.json', 'deno.jsonc')
        return root(vim.api.nvim_buf_get_name(0)) ~= nil
      end
      mason_lspconfig.setup_handlers({
        function(server)
          local config = {
            capabilities = vim.lsp.protocol.make_client_capabilities(),
          }
          local avariable_cmp, cmp = pcall(require, 'cmp_nvim_lsp')
          if avariable_cmp then
            config.capabilities = vim.tbl_deep_extend('force', config.capabilities, cmp.default_capabilities())
          end
          lspconfig[server].setup(config)
        end,
        ts_ls = function()
          if not is_deno() then
            lspconfig.tsserver.setup({})
          end
        end,
        denols = function()
          if is_deno() then
            lspconfig.denols.setup({})
          end
        end,
        lua_ls = function()
          lspconfig.lua_ls.setup({
            settings = {
              Lua = {
                diagnostics = {
                  globals = { 'vim' },
                },
                workspace = {
                  checkThirdParty = false,
                },
                telemetry = { enabled = false },
              },
            },
          })
        end,
        powershell_es = function()
          lspconfig.powershell_es.setup({
            bundle_path = vim.fn.stdpath('data') .. '/mason/packages/powershell-editor-services',
          })
        end,
      })

      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'qf',
        callback = function()
          vim.opt_local.buflisted = false
        end,
      })
      vim.api.nvim_create_autocmd('BufLeave', {
        callback = function()
          if vim.bo.buftype == 'quickfix' then
            vim.cmd.cclose()
          end
        end,
      })
    end,
  },
  {
    'jay-babu/mason-null-ls.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      'williamboman/mason.nvim',
      'nvimtools/none-ls.nvim',
    },
    config = function()
      require('mason-null-ls').setup({
        ensure_installed = { 'stylua' },
        automatic_installation = true,
        handlers = {},
      })
    end,
  },
  {
    'jmbuhr/otter.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      'neovim/nvim-lspconfig',
      'nvim-treesitter/nvim-treesitter',
    },
    config = function()
      local otter = require('otter')
      otter.setup({
        buffers = {
          set_filetype = true,
        },
      })
      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'html',
        callback = function()
          otter.activate({ 'css', 'javascript' }, true, true)
        end,
      })
    end,
  },
  {
    'elentok/format-on-save.nvim',
    event = 'BufWritePre',
    opts = {},
  },
}
