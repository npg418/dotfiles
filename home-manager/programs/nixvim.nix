{
  pkgs,
  lib,
  config,
  ...
}:
let
  restart-code = "10";
in
{
  home.packages = [
    (lib.hiPrio (
      pkgs.writeScriptBin "nvim" ''
        while true; do
          ${config.programs.nixvim.build.package}/bin/nvim "$@"
          if [ $? -ne ${restart-code} ]; then break; fi
        done
      ''
    ))
  ];
  programs = {
    nixvim =
      { lib, ... }:
      {
        enable = true;
        defaultEditor = true;
        vimdiffAlias = true;

        plugins.toggleterm.enable = true;
        userCommands.HMSwitch = {
          command = lib.nixvim.mkRaw ''
            function()
              local Terminal = require("toggleterm.terminal").Terminal
              Terminal:new({
                cmd = "home-manager switch",
                on_exit = function ()
                  vim.cmd("cquit ${restart-code}")
                end,
              }):toggle()
            end
          '';
        };
      };

    zsh.zsh-abbr.abbreviations.v = "nvim";
  };
}
