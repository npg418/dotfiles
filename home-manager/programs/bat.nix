{ pkgs, ... }:
{
  programs.bat = {
    enable = true;
    config.theme = "CatppuccinMocha";
    themes =
      let
        src = pkgs.fetchFromGitHub {
          owner = "catppuccin";
          repo = "bat";
          rev = "6810349b28055dce54076712fc05fc68da4b8ec0";
          sha256 = "lJapSgRVENTrbmpVyn+UQabC9fpV1G1e+CdlJ090uvg=";
        };
      in
      {
        CatppuccinMocha = {
          inherit src;
          file = "themes/Catppuccin Mocha.tmTheme";
        };
        CatppuccinLatte = {
          inherit src;
          file = "themes/Catppuccin Latte.tmTheme";
        };
        CatppuccinFrappe = {
          inherit src;
          file = "themes/Catppuccin Frappe.tmTheme";
        };
        CatppuccinMacchiato = {
          inherit src;
          file = "themes/Catppuccin Macchiato.tmTheme";
        };
      };
  };
}
