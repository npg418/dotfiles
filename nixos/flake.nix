{
  description = "NixOS configuration of NPG418";
  outputs =
    { ... }:
    {
      nixosModules.default =
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
        };
    };
}
