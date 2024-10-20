{ pkgs, ... }:

{
  programs.zsh.enable = true;
  users.users.nullp.shell = pkgs.zsh;
  i18n.defaultLocale = "ja_JP.UTF-8";
}
