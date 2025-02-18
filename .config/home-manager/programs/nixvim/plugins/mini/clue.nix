{
  nixvim,
  lib,
  config,
  ...
}:
{
  programs.nixvim.plugins.mini.modules.clue = {
    triggers = [
      # Leader triggers
      {
        mode = "n";
        keys = "<Leader>";
      }
      {
        mode = "x";
        keys = "<Leader>";
      }

      # `g` key
      {
        mode = "n";
        keys = "g";
      }
      {
        mode = "x";
        keys = "g";
      }

      # Marks
      {
        mode = "n";
        keys = "'";
      }
      {
        mode = "n";
        keys = "`";
      }
      {
        mode = "x";
        keys = "'";
      }
      {
        mode = "x";
        keys = "`";
      }

      # Registers
      {
        mode = "n";
        keys = "\"";
      }
      {
        mode = "x";
        keys = "\"";
      }
      {
        mode = "i";
        keys = "<C-r>";
      }
      {
        mode = "c";
        keys = "<C-r>";
      }

      # Window commands
      {
        mode = "n";
        keys = "<C-w>";
      }

      # `z` key
      {
        mode = "n";
        keys = "z";
      }
      {
        mode = "x";
        keys = "z";
      }
    ] ++ lib.optionals (builtins.hasAttr "bracketed" config.programs.nixvim.plugins.mini.modules) [
      {
        mode = "n";
        keys = "[";
      }
      {
        mode = "n";
        keys = "[";
      }
    ];
    clues = map (fnName: nixvim.mkRaw "require(\"mini.clue\").gen_clues.${fnName}()") [
      "g"
      "marks"
      "registers"
      "windows"
      "z"
    ];
    delay = 200;
  };
}
