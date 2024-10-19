{ ... }:
let
  moz-overlay = import (
    builtins.fetchTarball "https://github.com/mozilla/nixpkgs-mozilla/archive/master.tar.gz"
  );
  nixpkgs = import <nixpkgs> { overlays = [ moz-overlay ]; };

  theme-catppuccin-mocha-toml = builtins.readFile (
    builtins.fetchurl "https://raw.githubusercontent.com/catppuccin/starship/refs/heads/main/themes/mocha.toml"
  );
  theme-catppuccin-mocha = nixpkgs.lib.fromTOML theme-catppuccin-mocha-toml;
in
{
  programs.starship = {
    enable = true;
    settings = {
      palette = "catppuccin_mocha";
      character = {
        success_symbol = "[[󰄛](green) ❯](peach)";
        error_symbol = "[[󰄛](red) ❯](peach)";
        vimcmd_symbol = "[󰄛 ❮](subtext1)";
      };
      git_branch.style = "bold mauve";
      directory = {
        truncation_length = 4;
        style = "bold lavender";
      };
    } // theme-catppuccin-mocha;
  };
}
