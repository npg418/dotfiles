nixvim: modules:
{ config, lib, ... }:
let
  cfg = config.programs.nixvim;
  evalArgs = {
    extraSpecialArgs = {
      hmConfig = config;
    };
    modules = [
      (nixvim + "/wrappers/modules/hm.nix")
      ./module.nix
    ] ++ modules;
  };
in
{
  _file = ./hm.nix;

  imports = [
    (import (nixvim + "/wrappers/_shared.nix") {
      inherit evalArgs;
      self = nixvim;
      filesOpt = [
        "xdg"
        "configFile"
      ];
    })
  ];

  config = lib.mkIf cfg.enable {
    home.packages = [
      cfg.build.package
    ];

    home.sessionVariables = lib.mkIf cfg.defaultEditor { EDITOR = "nvim"; };

    programs = lib.mkIf cfg.vimdiffAlias {
      bash.shellAliases.vimdiff = "nvim -d";
      fish.shellAliases.vimdiff = "nvim -d";
      zsh.shellAliases.vimdiff = "nvim -d";
    };
  };
}
