return {
  'nvim-neo-tree/neo-tree.nvim',
  branch = 'v3.x',
  keymap = {
    { 'n', '<C-n>', '<cmd>NeoTree<CR>' }
  },
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    'MunifTanjim/nui.nvim',
    '3rd/image.nvim',
  },
  config = function()
    require 'neo-tree'.setup();
  end
}
