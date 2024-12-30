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
      Defaults:always_set_home
      Defaults:requiretty
      Defaults!/usr/bin/visudo env_keep += "SUDO_EDITOR EDITOR VISUAL"
      Defaults:secure_path="${lib.makeBinPath [systemd]}:/nix/var/nix/profiles/default/bin:/run/current-system/sw/bin"
    '';
  };
}
