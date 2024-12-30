{ inputs
, outputs
, config
, lib
, pkgs
, ...
}:{
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
    extraConfig = with pkgs; ''
      Cmnd_Alias	DEBUGGERS = /usr/bin/gdb, /usr/bin/lldb, /usr/bin/strace, /usr/bin/truss, /usr/bin/bpftrace, /usr/bin/dtrace, /usr/bin/dtruss
      Cmnd_Alias	PKGMAN = /usr/bin/apt, /usr/bin/dpkg, /usr/bin/rpm, /usr/bin/yum, /usr/bin/dnf,  /usr/bin/zypper, /usr/bin/pacman
      Cmnd_Alias	PROCESSES = /usr/bin/nice, /bin/kill, /usr/bin/renice, /usr/bin/pkill, /usr/bin/top
      Cmnd_Alias	REBOOT = /sbin/halt, /sbin/reboot, /sbin/poweroff
      Defaults    always_set_home
      Defaults    env_keep += "LC_COLLATE LC_IDENTIFICATION LC_MEASUREMENT LC_MESSAGES"
      Defaults    env_keep += "LC_MONETARY LC_NAME LC_NUMERIC LC_PAPER LC_TELEPHONE"
      Defaults    env_keep += "LC_TIME LC_ALL LANGUAGE LINGUAS _XKB_CHARSET XAUTHORITY"
      Defaults    env_keep += "MAIL PS1 PS2 QTDIR USERNAME LANG LC_ADDRESS LC_CTYPE"
      Defaults    env_keep =  "COLORS DISPLAY HOSTNAME HISTSIZE INPUTRC KDEDIR LS_COLORS"
      Defaults    requiretty
      Defaults    secure_path="${lib.makeBinPath [systemd]}:/nix/var/nix/profiles/default/bin:/run/current-system/sw/bin"
      Defaults!/usr/bin/visudo env_keep += "SUDO_EDITOR EDITOR VISUAL"
    '';
  };
}
