{ ... }:
let
  default-modules = [
    "ai"
    "align"
    "animate"
    "basics"
    "colors"
    "comment"
    "cursorword"
    "diff"
    "extra"
    "git"
    "indentscope"
    "icons"
    "jump"
    "misc"
    "move"
    "pairs"
    "splitjoin"
    "starter"
    "statusline"
    "surround"
    "trailspace"
    "visits"
  ];
  modules = builtins.listToAttrs (
    map (name: {
      inherit name;
      value = { };
    }) default-modules
  );
in
{
  imports = [
    ./bracketed.nix
    ./bufremove.nix
    ./clue.nix
    ./files.nix
    ./hipatterns.nix
    ./notify.nix
    ./pick.nix
    ./sessions.nix
    ./tabline.nix
  ];

  programs.nixvim = {
    plugins.mini = {
      enable = true;
      mockDevIcons = true;
      inherit modules;
    };
  };
}
