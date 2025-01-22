{ pkgs, lib, ... }:

let
  fromGitHub =
    { owner, repo, ... }@spec:
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
        rev = "e0eddbe28ab12ea331cd4935fc7387429a689575";
        sha256 = "sha256-cOGbHdUgmFyMKdnzPFP6XNiHFI/XIAgbuQBWC+Cq9QA=";
      }) ./vimdoc-ja.lua)
      efmls-configs-nvim
      (withConfig toggleterm-nvim ./toggleterm.lua)
      (fromGitHub {
        owner = "willelz";
        repo = "neovimdoc-ja";
        rev = "c1374d46a4bb77c0f9f50d1c8f781e2beb7a539d";
        sha256 = "sha256-sqig96jiu4ljAhwIyqZW0q+s90zK5AplNIO3elc/1Po=";
      })
      (withConfig lazygit-nvim ./lazygit.lua)
      (withConfig vim-suda ./suda.lua)
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
