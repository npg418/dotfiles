{
  pkgs,
  lib,
  ...
}:
{
  programs.home-manager.enable = lib.mkForce false;

  nixpkgs.overlays = [
    (self: super: {
      home-manager = super.home-manager.overrideAttrs (old: {
        patches = old.patches or [ ] ++ [ ./home-manager.patch ];
      });
    })
  ];

  home.packages = [
    pkgs.home-manager
  ];
}
