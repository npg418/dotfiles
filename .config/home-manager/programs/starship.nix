{ ... }:
let
  theme-catppuccin-mocha-toml = builtins.readFile (
    builtins.fetchurl {
      url = "https://raw.githubusercontent.com/catppuccin/starship/refs/heads/main/themes/mocha.toml";
      sha256 = "170zl263qd4542ccfqrfcn10qvppafbsnxs5vbfxx4yv4ynrj9ki";
    }
  );
  theme-catppuccin-mocha = fromTOML theme-catppuccin-mocha-toml;
in
{
  programs.starship = {
    enable = true;
    settings = {
      palette = "catppuccin_mocha";
      # format reference: https://starship.rs/presets/tokyo-night
      format = ''
        [░▒▓](rosewater)[ 󰄛 ](bg:rosewater fg:surface1)[](bg:mauve fg:rosewater)$directory[](fg:mauve bg:maroon)$git_branch$git_status[](fg:maroon bg:green)$time[](fg:green)
        $character
      '';
      directory = {
        style = "fg:surface1 bg:mauve";
        format = "[ $path $read_only ]($style)";
        read_only = "󰌾";
        repo_root_format = "[  $repo_root]($repo_root_style $style)[$path $read_only]($style)";
        repo_root_style = "bold";
        truncation_length = 4;
        truncation_symbol = "…󰉓 /";
      };
      git_branch = {
        symbol = "";
        style = "bg:maroon";
        format = "[[ $symbol $branch ](fg:surface1 bg:maroon)]($style)";
      };
      git_status = {
        style = "bg:maroon";
        format = "[[(\\[$all_status$ahead_behind\\] )](fg:surface1 bg:maroon)]($style)";
      };
      time = {
        disabled = false;
        time_format = "%R";
        style = "bg:green";
        format = "[[  $time ](fg:surface1 bg:green)]($style)";
      };
      character = {
        success_symbol = "[ ❯](green)";
        error_symbol = "[ ❯](red)";
        vimcmd_symbol = "[ ❮](subtext0)";
      };
    } // theme-catppuccin-mocha;
  };
}
