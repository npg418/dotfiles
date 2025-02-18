{ pkgs, lib, ... }:
let
  fromGitHub =
    {
      owner,
      repo,
      rev,
      ...
    }@spec:
    pkgs.vimUtils.buildVimPlugin {
      pname = lib.strings.sanitizeDerivationName "${owner}/${repo}";
      version = rev;
      src = pkgs.fetchFromGitHub spec;
    };
in
{
  programs.nixvim = {
    extraPlugins = [
      {
        plugin = fromGitHub {
          owner = "vim-jp";
          repo = "vimdoc-ja";
          rev = "7e381730febb695fb58c9d6c8fd867226180ca2d";
          hash = "sha256-x3UxwC16jWqlaVBWGCdc6g5bLOZJMtd6fqTUkM5cedA=";
        };
        config = ''
          set helplang = "ja,en"
        '';
      }
    ];
  };
}
