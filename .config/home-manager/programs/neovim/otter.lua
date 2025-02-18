local otter = require("otter")

vim.api.nvim_create_autocmd({ "LspAttach", "TextChanged" }, {
  callback = function()
    otter.activate()
  end,
})
