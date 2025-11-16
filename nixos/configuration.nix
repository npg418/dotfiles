{ pkgs, ... }:
{
  system.stateVersion = "25.05";
  i18n.defaultLocale = "ja_JP.UTF-8";
  time.timeZone = "Asia/Tokyo";
  programs = {
    zsh.enable = true;
    nix-ld.enable = true;
  };
  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
    autoPrune.enable = true;
  };
  users.users.nullp = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
    ];
    shell = pkgs.zsh;
  };
  environment.pathsToLink = [ "/share/zsh" ];
  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    trusted-users = [
      "root"
      "nullp"
    ];
  };
  fonts = {
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-extra
      noto-fonts-emoji
      hackgen-nf-font
      dejavu_fonts
    ];
    fontconfig = {
      enable = true;
      defaultFonts = {
        sansSerif = [
          "Noto Sans CJK JP"
          "DejaVu Sans"
        ];
        serif = [
          "Noto Serif JP"
          "DejaVu Serif"
        ];
        monospace = [
          "HackGen Console NF"
          "DejaVu Sans Mono"
        ];
      };
      subpixel.lcdfilter = "light";
    };
  };
  services.openssh = {
    enable = true;
    settings = {
      PermitTunnel = "yes";
    };
  };
}
