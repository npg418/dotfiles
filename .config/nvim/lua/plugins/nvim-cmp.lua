return {
  'hrsh7th/nvim-cmp',
  event = 'InsertEnter',
  dependencies = {
    {
      'L3MON4D3/LuaSnip',
      version = "2.*",
      dependencies = {
        'saadparwaiz1/cmp_luasnip',
        'rafamadriz/friendly-snippets',
      },
    },
    'hrsh7th/cmp-nvim-lsp',
    'onsails/lspkind.nvim',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
  },
  config = function()
    local cmp = require('cmp')
    local luasnip = require('luasnip')
    local lspkind = require('lspkind')
    require('luasnip.loaders.from_vscode').lazy_load()
    luasnip.config.setup()
    cmp.setup({
      completion = {
        completeopt = 'menu,menuone,noinsert',
      },
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ['<TAB>'] = cmp.mapping(function(fallback)
          if not cmp.visible() then
            fallback()
          end

          local entry = cmp.get_selected_entry()
          if entry then
            cmp.select_next_item({ behavior = cmp.SelectBehavior.select })
          else
            cmp.select_next_item()
          end
        end, { 'i', 's', 'c', }),
        ['<S-TAB>'] = cmp.mapping.select_prev_item(),
        ['<C-e>'] = cmp.mapping({
          i = cmp.mapping.abort(),
          n = cmp.mapping.close(),
        }),
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-u>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
      }),
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
      sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        {
          name = 'buffer',
          option = {
            get_bufnrs = function()
              return vim.api.nvim_list_bufs()
            end
          },
        },
        { name = 'path' },
      }),
      formatting = {
        fields = { 'abbr', 'kind', 'menu' },
        format = lspkind.cmp_format({
          mode = 'symbol_text',
          maxwidth = 50,
          ellipsis_char = '...',
          menu = ({
            buffer = '[Buffer]',
            nvim_lsp = '[LSP]',
            path = '[Path]',
          }),
        }),
      },
      experimental = {
        ghost_text = true,
      },
    })

    vim.o.pumheight = 14
  end,
}
