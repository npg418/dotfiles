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
      { 'K', vim.lsp.hover },
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
          local config = {}
          local avariable_custom, custom = pcall(require, 'servers.' .. server)
          if avariable_custom then
            config = custom
          end
          local avariable_cmp, cmp = pcall(require, 'cmp_nvim_lsp')
          if avariable_cmp then
            config.capabilites = cmp.default_capabilities()
          end
          lspconfig[server].setup(config)
        end,
        tsserver = function()
          if not is_deno() then
            lspconfig.tsserver.setup()
          end
        end,
        denols = function()
          if is_deno() then
            lspconfig.denols.setup()
          end
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
    'elentok/format-on-save.nvim',
    event = 'BufWritePre',
    opts = {},
  },
}
