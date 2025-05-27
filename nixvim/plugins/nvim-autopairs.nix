{
  plugins.nvim-autopairs = {
    enable = true;
    settings = {
      check_ts = true;
    };
  };
  extraFiles = {
    "ftplugin/nix.lua".text = ''
      local Rule = require("nvim-autopairs.rule")
      local npairs = require("nvim-autopairs")
      local ts_conds = require("nvim-autopairs.ts-conds")

      npairs.add_rule(Rule("'''", "'''", "nix"):with_pair(ts_conds.is_not_ts_node("indented_string_expression")))
    '';
  };
}
