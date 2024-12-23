{ pkgs, lib, ... }:

let
  fromGitHub =
    owner: repo: hash:
    pkgs.vimUtils.buildVimPlugin {
      pname = lib.strings.sanitizeDerivationName owner + "/" + repo;
      version = "fromGitHub";
      src = pkgs.fetchFromGitHub {
        inherit owner;
        inherit repo;
        rev = "HEAD";
        inherit hash;
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
      # (withConfig neodev-nvim ./neodev.lua)
      (withConfig lazydev-nvim ./lazydev.lua)
      (withConfig coq_nvim ./coq.lua)
      coq-artifacts
      # (withConfig coq-thirdparty ./coq-thirdparty.lua)
      (withConfig nvim-lspconfig ./lspconfig.lua)
      (withConfig catppuccin-nvim ./catppuccin.lua)
      (withConfig mini-nvim ./mini.lua)
      (withConfig (fromGitHub "vim-jp" "vimdoc-ja"
        "sha256-q2TPqTOzV4Wngdhr4yrGsyKEod535SMU8fp5X8Ioch4="
      ) ./vimdoc-ja.lua)
      efmls-configs-nvim
      (withConfig toggleterm-nvim ./toggleterm.lua)
      (fromGitHub "willelz" "neovimdoc-ja" "sha256-sqig96jiu4ljAhwIyqZW0q+s90zK5AplNIO3elc/1Po=")
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
