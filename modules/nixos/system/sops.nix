{
  lib,
  config,
  ...
}:
let
  cfg = config.cm.nixos.system.sops;
in
{
  options.cm.nixos.system.sops = {
    enable = lib.mkEnableOption "Enable sops";
  };

  config = lib.mkIf cfg.enable {
    sops = {
      age = {
        sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
        generateKey = true;
      };
    };
  };
}
