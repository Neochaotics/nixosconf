{ lib,
  pkgs,
  ...
}:{
  security.sudo = {
    enable = lib.mkForce false;
    extraConfig = lib.mkForce [ ];
  };
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
      Defaults always_set_home
      Defaults secure_path="${lib.makeBinPath [systemd]}:/nix/var/nix/profiles/default/bin:/run/current-system/sw/bin"
    '';
  };
}
