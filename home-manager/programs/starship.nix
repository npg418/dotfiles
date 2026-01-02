let
  catppuccin-powerline-preset-toml = builtins.readFile (
    builtins.fetchurl {
      url = "https://starship.rs/presets/toml/catppuccin-powerline.toml";
      sha256 = "0bd8zx0bpri63rnb9dva0rav75d3i2wrzw44h63m75hq5220r26g";
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
