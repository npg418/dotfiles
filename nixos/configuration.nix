{ pkgs, ... }:
{
  i18n.defaultLocale = "ja_JP.UTF-8";
  time.timeZone = "Asia/Tokyo";
  programs.zsh.enable = true;
  users.users.nullp = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
    ];
    shell = pkgs.zsh;
  };
  environment.pathsToLink = [ "/share/zsh" ];
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
}
