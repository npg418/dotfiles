let
  catppuccin-powerline-preset-toml = builtins.readFile (
    builtins.fetchurl {
      url = "https://starship.rs/presets/toml/catppuccin-powerline.toml";
      sha256 = "0j4jp769nqjcrzr3wjwahmzg5a5mxg2asy5vsh6l7y95258pwpr1";
    }
  );
  catppuccin-theme = fromTOML catppuccin-powerline-preset-toml;
in
{
  programs.starship = {
    enable = true;
    settings = catppuccin-theme;
  };
}
