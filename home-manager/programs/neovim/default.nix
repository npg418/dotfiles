{
  pkgs,
  lib,
  ...
}:
let
  fromGitHub =
    {
      owner,
      repo,
      ...
    }@spec:
    pkgs.vimUtils.buildVimPlugin {
      pname = lib.strings.sanitizeDerivationName owner + "/" + repo;
      version = "fromGitHub";
      src = pkgs.fetchFromGitHub spec;
    };
  withConfig = plugin: configFile: {
    inherit plugin;
    config = builtins.readFile configFile;
    type = "lua";
  };
in
{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    defaultEditor = true;
    plugins = with pkgs.vimPlugins; [
      nvim-treesitter.withAllGrammars
      plenary-nvim
      # (withConfig hardtime-nvim ./hardtime.lua)
      # (withConfig neodev-nvim ./neodev.lua)
      (withConfig lazydev-nvim ./lazydev.lua)
      (withConfig coq_nvim ./coq.lua)
      coq-artifacts
      # (withConfig coq-thirdparty ./coq-thirdparty.lua)
      (withConfig nvim-lspconfig ./lspconfig.lua)
      (withConfig catppuccin-nvim ./catppuccin.lua)
      (withConfig mini-nvim ./mini.lua)
      (withConfig (fromGitHub {
        owner = "vim-jp";
        repo = "vimdoc-ja";
        rev = "b1d774c43e74dc45d03f1880c9e83f8aaa5f1a0d";
        sha256 = "sha256-xXCXMxApPGyUODV9MK1H3qvFGpGvJe78ZarG1MHFhY0=";
      }) ./vimdoc-ja.lua)
      efmls-configs-nvim
      (withConfig toggleterm-nvim ./toggleterm.lua)
      (withConfig lazygit-nvim ./lazygit.lua)
      (withConfig vim-suda ./suda.lua)
      (withConfig lsp-format-nvim ./lsp-format.lua)
    ];
    extraLuaConfig = builtins.readFile ./init.lua;
    extraPackages = with pkgs; [
      ripgrep
      efm-langserver
      nil
      nixfmt-rfc-style
      lua-language-server
      stylua
      lazygit
      bash-language-server
      beautysh
      markdown-oxide
    ];
  };
}
