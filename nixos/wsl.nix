{
  pkgs,
  lib,
  config,
  ...
}:
{
  wsl = {
    enable = true;
    defaultUser = "nullp";
    wslConf = {
      automount.root = "/mnt";
      network.generateHosts = false;
    };
    docker-desktop.enable = false;
    extraBin = with pkgs; [
      { src = "${coreutils}/bin/mkdir"; }
      { src = "${coreutils}/bin/cat"; }
      { src = "${coreutils}/bin/whoami"; }
      { src = "${coreutils}/bin/ls"; }
      { src = "${busybox}/bin/addgroup"; }
      { src = "${su}/bin/groupadd"; }
      { src = "${su}/bin/usermod"; }
    ];
  };
  systemd.services.docker-desktop-proxy.script = lib.mkForce ''${config.wsl.wslConf.automount.root}/wsl/docker-desktop/docker-desktop-user-distro proxy --docker-desktop-root ${config.wsl.wslConf.automount.root}/wsl/docker-desktop "C:\Program Files\Docker\Docker\resources"'';
  environment = {
    systemPackages = [ pkgs.wl-clipboard ];
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
