{
  lib,
  config,
  ...
}:
let
  cfg = config.cmodule.nixos.common.persistence;
in
{
  options.cmodule.nixos.common.persistence = {
    enable = lib.mkEnableOption "Enable configuration";
  };

  config = lib.mkIf cfg.enable {
    environment.persistence = {
      "/persist" = {
        enable = true;
        hideMounts = true;
        directories = [
          "/var/log"
          "/var/lib/bluetooth"
          "/var/lib/nixos"
          "/var/lib/systemd/coredump"
          "/etc/NetworkManager/system-connections"
          "/etc/nixos"
          {
            directory = "/var/lib/colord";
            user = "colord";
            group = "colord";
            mode = "u=rwx,g=rx,o=";
          }
        ];
        files = [
          "/etc/machine-id"
          {
            file = "/var/keys/secret_file";
            parentDirectory = {
              mode = "u=rwx,g=,o=";
            };
          }
        ];
      };
    };
  };
}
