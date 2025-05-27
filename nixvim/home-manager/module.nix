{
  pkgs,
  lib,
  config,
  ...
}:
let
  restartCode = "10";
  defaultSession = "_restart";
in
{
  programs.nixvim = {
    enable = true;
    plugins = {
      toggleterm.enable = true;
      mini = {
        enable = true;
        modules.sessions = {
          autowrite = true;
          autoread = config.lib.nixvim.mkRaw "vim.g.restarted or false";
          hooks.post.read = config.lib.nixvim.mkRaw ''
            function(session)
              if session.name == "${defaultSession}" then
                MiniSessions.delete(session.name, { force = true })
              end
            end
          '';
        };
      };
    };
    userCommands = {
      Restart = {
        command = config.lib.nixvim.mkRaw ''
          function()
            if not vim.v.this_session then
              MiniSessions.write(${defaultSession})
            end
            vim.cmd("cquit ${restartCode}")
          end
        '';
      };
      HMSwitch = {
        command = config.lib.nixvim.mkRaw ''
          function(opts)
            if not opts.bang then
              for _, buf in ipairs(vim.api.nvim_list_bufs()) do
                if vim.api.nvim_buf_is_loaded(buf) and vim.api.nvim_get_option_value("modified", { buf = buf }) then
                  vim.notify("Unsaved modification in buffer " .. buf .. ". Aborting HMSwitch.", vim.log.levels.ERROR)
                  return
                end
              end
            end
            local Terminal = require("toggleterm.terminal").Terminal
            local hm_switch = Terminal:new({
              cmd = "home-manager switch",
              display_name = "Home manager switch",
              direction = "float",
              close_on_exit = true,
              on_exit = function(_, _, code, _)
                if code ~= 0 then
                  vim.notify("`home-manager switch` did not complete successfully.", vim.log.levels.ERROR)
                  vim.print("Press any key to continue...")
                  vim.fn.getchar()
                else
                  if not vim.v.this_session then
                    MiniSessions.write(${defaultSession})
                  end
                  vim.cmd("cquit ${restartCode}")
                end
              end
            })
            hm_switch:toggle()
          end
        '';
        bang = true;
        desc = "Run `home-manager switch` and reload neovim config. (home-manager)";
      };
    };
  };
  home.packages = with pkgs; [
    (lib.hiPrio (
      writeShellScriptBin "nvim" ''
        nvim=${config.programs.nixvim.build.package}/bin/nvim
        while true; do
          if [ "$restarted" = true ]; then
            $nvim --cmd "let g:restarted=v:true"
          else
            $nvim "$@"
          fi
          if [ $? -eq ${restartCode} ]; then
            echo "Restart code recieved. Restarting neovim..."
            restarted=true
          else
            break
          fi
        done
      ''
    ))
    gcc
  ];
  programs.zsh.zsh-abbr.abbreviations.v = "nvim";
}
