{ pkgs, lib, ... }:

let
  fromGitHub =
    repo:
    pkgs.vimUtils.buildVimPlugin {
      pname = "${lib.strings.sanitizeDerivationName repo}";
      version = "HEAD";
      src = builtins.fetchGit {
        url = "https://github.com/${repo}.git";
        ref = "HEAD";
      };
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
      (withConfig neodev-nvim ./neodev.lua)
      (withConfig coq_nvim ./coq.lua)
      coq-artifacts
      (withConfig coq-thirdparty ./coq-thirdparty.lua)
      (withConfig nvim-lspconfig ./lspconfig.lua)
      (withConfig catppuccin-nvim ./catppuccin.lua)
      (withConfig (fromGitHub "echasnovski/mini.nvim") ./mini.lua)
      (withConfig (fromGitHub "vim-jp/vimdoc-ja") ./vimdoc-ja.lua)
      efmls-configs-nvim
      (withConfig toggleterm-nvim ./toggleterm.lua)
      (fromGitHub "willelz/neovimdoc-ja")
      (withConfig lazygit-nvim ./lazygit.lua)
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
    ];
  };
}
