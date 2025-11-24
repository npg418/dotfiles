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
    settings = catppuccin-theme;
  };
  nixpkgs.overlays = [
    (final: prev: {
      starship =
        (prev.starship.override {
          rustPlatform = final.makeRustPlatform {
            cargo = final.rust-bin.stable.latest.default;
            rustc = final.rust-bin.stable.latest.default;
          };
        }).overrideAttrs
          (drv: rec {
            inherit (drv) pname;
            version = "1.24.1";
            src = prev.fetchFromGitHub {
              owner = "starship";
              repo = "starship";
              tag = "v${version}";
              hash = "sha256-yWG06l/Gu2/u4NNAyCYjxlmEKIsDAaxWGp6fmqXvNl8=";
            };
            cargoDeps = final.rustPlatform.fetchCargoVendor {
              inherit src;
              hash = "sha256-F7tzrMqF2xY8Ow+bAFbP0mQPomSe/oOHiQWHRHDmHio=";
            };
          });
    })
  ];
}
