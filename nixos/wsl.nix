{ pkgs, ... }:
{
  wsl = {
    enable = true;
    defaultUser = "nullp";
    wslConf = {
      automount.root = "/mnt";
      network.generateHosts = false;
    };
  };

  environment = {
    systemPackages = with pkgs; [
      wl-clipboard
      wslu
    ];
    variables = {
      WSLROOT = "/mnt/c/Users/nullp/";
    };
  };

  systemd.user.services.wayland-socket-linker = {
    enable = true;
    description = "Wayland socket symlink for WSLg";

    unitConfig = {
      After = [ "default.target" ];
      Requires = [ "default.target" ];
    };

    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.bash}/bin/bash -c 'find /mnt/wslg/runtime-dir -name \"wayland-*\" -exec ln -sf {} /run/user/$(id -u)/ \\;'";
      RemainAfterExit = true;
    };

    wantedBy = [ "default.target" ];
  };
}
