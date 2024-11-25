require("neodev").setup({
  override = function(root_dir, library)
    if root_dir:find("dotfiles/.config/home-manager/programs/neovim", 1, true) then
      library.enabled = true
      library.plugins = true
    end
  end,
})
