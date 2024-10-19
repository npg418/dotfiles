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
in
{
  nixpkgs.config = {
    packageOverrides =
      pkgs:
      let
        pkgs' = import <nixpkgs-unstable> {
          inherit (pkgs) system;
          overlays = [
            (import (
              builtins.fetchTarball {
                url = "https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz";
              }
            ))
          ];
        };
      in
      {
        inherit (pkgs') neovim;
      };
  };
  programs.neovim = {
    enable = true;
    package = pkgs.neovim;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    defaultEditor = true;
    plugins = with pkgs.vimPlugins; [
      nvim-treesitter.withAllGrammars
      plenary-nvim
      {
        plugin = nvim-lspconfig;
        config = builtins.readFile ./lspconfig.lua;
        type = "lua";
      }
      {
        plugin = catppuccin-nvim;
        config = builtins.readFile ./catppuccin.lua;
        type = "lua";
      }
      {
        plugin = fromGitHub "echasnovski/mini.nvim";
        config = builtins.readFile ./mini.lua;
        type = "lua";
      }
      {
        plugin = fromGitHub "vim-jp/vimdoc-ja";
        config = builtins.readFile ./vimdoc-ja.lua;
        type = "lua";
      }
      {
        plugin = fromGitHub "folke/lazydev.nvim";
        config = builtins.readFile ./lazydev.lua;
        type = "lua";
      }
      efmls-configs-nvim
      {
        plugin = toggleterm-nvim;
        config = builtins.readFile ./toggleterm.lua;
        type = "lua";
      }
      (fromGitHub "willelz/neovimdoc-ja")
      {
        plugin = lazygit-nvim;
        config = builtins.readFile ./lazygit.lua;
        type = "lua";
      }
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
