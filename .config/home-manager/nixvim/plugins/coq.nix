{
  plugins = {
    coq-nvim = {
      enable = true;
      installArtifacts = true;
      settings.auto_start = "shut-up";
    };
    coq-thirdparty = {
      enable = true;
      sources = [
        {
          src = "repl";
          short_name = "SHELL";
        }
        {
          src = "bc";
          short_name = "MATH";
        }
        {
          src = "copilot";
          short_name = "COP";
          accept_key = "<C-f>";
        }
      ];
    };
    lsp.setupWrappers = [ (opt: "require(\"coq\").lsp_ensure_capabilities(${opt})") ];
  };
}
