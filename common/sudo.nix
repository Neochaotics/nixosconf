{ pkgs
, lib
}: {
  security.sudo.enable = false;
  security.sudo-rs = {
    enable = true;
    execWheelOnly = true;
    extraRules = [{
      commands = [
        {
          command = "${pkgs.systemd}/bin/reboot";
          options = [ "NOPASSWD" ];
        }
        {
          command = "${pkgs.systemd}/bin/poweroff";
          options = [ "NOPASSWD" ];
        }
      ];
      groups = [ "wheel" ];
    }];
      # Cmnd_Alias:DEBUGGERS = /usr/bin/gdb, /usr/bin/lldb, /usr/bin/strace, /usr/bin/truss, /usr/bin/bpftrace, /usr/bin/dtrace, /usr/bin/dtruss
      # Cmnd_Alias:PKGMAN = /usr/bin/apt, /usr/bin/dpkg, /usr/bin/rpm, /usr/bin/yum, /usr/bin/dnf,  /usr/bin/zypper, /usr/bin/pacman
      # Cmnd_Alias:PROCESSES = /usr/bin/nice, /bin/kill, /usr/bin/renice, /usr/bin/pkill, /usr/bin/top
      # Cmnd_Alias:REBOOT = /sbin/halt, /sbin/reboot, /sbin/poweroff
    extraConfig = with pkgs; ''
      Defaults:always_set_home
      Defaults:requiretty
      Defaults!/usr/bin/visudo env_keep += "SUDO_EDITOR EDITOR VISUAL"
      Defaults:secure_path="${lib.makeBinPath [systemd]}:/nix/var/nix/profiles/default/bin:/run/current-system/sw/bin"
    '';
  };
}
