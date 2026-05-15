let
  catppuccin-powerline-preset-toml = builtins.readFile (
    builtins.fetchurl {
      url = "https://starship.rs/presets/toml/catppuccin-powerline.toml";
      sha256 = "1jzbbzm3nwdlldq43aj3csp0ps23fsa6x2225z85l0s9qbj4cdy2";
    }
  );
  catppuccin-theme = fromTOML catppuccin-powerline-preset-toml;
in
{
  programs.starship = {
    enable = true;
    settings = catppuccin-theme // {
      palette = "catppuccin_macchiato";
      line_break.disabled = false;
    };
  };
}
