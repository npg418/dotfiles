let
  default-modules = [
    # "ai"
    # "align"
    "animate"
    "basics"
    "bracketed"
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
    # "pairs"
    "sessions"
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
    ./bufremove.nix
    ./clue.nix
    ./extra.nix
    ./files.nix
    ./hipatterns.nix
    ./notify.nix
    ./pick.nix
    ./tabline.nix
  ];

  plugins.mini = {
    enable = true;
    mockDevIcons = true;
    inherit modules;
  };
}
