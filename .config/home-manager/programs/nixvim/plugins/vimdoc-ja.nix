{ pkgs, ... }:
{
  programs.nixvim = {
    extraPlugins = [
      (pkgs.vimUtils.buildVimPlugin {
        name = "vimdoc-ja";
        src = pkgs.fetchFromGitHub {
          owner = "vim-jp";
          repo = "vimdoc-ja";
          rev = "7e381730febb695fb58c9d6c8fd867226180ca2d";
          hash = "sha256-x3UxwC16jWqlaVBWGCdc6g5bLOZJMtd6fqTUkM5cedA=";
        };
      })
    ];

    opts.helplang = "ja,en";
  };
}
