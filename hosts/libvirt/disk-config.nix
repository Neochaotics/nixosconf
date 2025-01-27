{ config, ... }:
{
  disko.devices.disk = {
    primary = {
      type = "disk";
      device = "/dev/disk/by-id/virtio-CT1000P5PSSD8_22343A";
      content = {
        type = "gpt";
        partitions = {
          ESP = {
            size = "512M";
            type = "EF00";
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
              mountOptions = [ "umask=0077" ];
            };
          };
          luks = {
            size = "100%";
            content = {
              type = "luks";
              name = "primarycrypt";
              settings = {
                allowDiscards = true;
                keyFile = "${config.sops.secrets.luks_key.path}";
              };
              content = {
                type = "btrfs";
                extraArgs = [ "-f" ];
                subvolumes = {
                  "/root" = {
                    mountpoint = "/";
                    mountOptions = [
                      "compress=zstd"
                      "noatime"
                    ];
                  };
                  "/persist" = {
                    mountpoint = "/persist";
                    mountOptions = [
                      "compress=zstd"
                      "noatime"
                    ];
                  };
                  "/nix" = {
                    mountpoint = "/nix";
                    mountOptions = [
                      "compress=zstd"
                      "noatime"
                    ];
                  };
                };
              };
            };
          };
        };
      };
    };
    secondary = {
      type = "disk";
      device = "/dev/disk/by-id/virtio-CT2000P5PSSD8_23113F";
      content = {
        type = "gpt";
        partitions = {
          luks = {
            size = "100%";
            content = {
              type = "luks";
              name = "secondarycrypt";
              settings = {
                allowDiscards = true;
                keyFile = "${config.sops.secrets.luks_key.path}";
              };
              #passwordFile = "/tmp/secondary.key";
              content = {
                type = "btrfs";
                extraArgs = [ "-f" ];
                subvolumes = {
                  "/games" = {
                    mountpoint = "/games";
                    mountOptions = [
                      "compress=zstd"
                      "noatime"
                    ];
                  };
                  "/persist/home" = {
                    mountpoint = "/persist/home";
                    mountOptions = [
                      "compress=zstd"
                      "noatime"
                    ];
                  };
                };
              };
            };
          };
        };
      };
    };
  };

  fileSystems."/persist".neededForBoot = true;
}
