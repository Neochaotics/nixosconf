{
  disko.devices = {
    disk = {
      primary = {
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              priority = 1;
              name = "ESP";
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
                name = "cryptroot";
                setting = {
                  allowDiscards = true;
                };
                content = {
                  type = "filesystem";
                  format = "btrfs";
                  extraArgs = [ "-f" ];
                  subvolumes = {
                    "@root" = {
                      mountpoint = "/";
                      mountOptions = [
                        "noatime"
                        "compress=zstd"
                      ];
                    };
                    "@persist" = {
                      mountpoint = "/persist";
                      mountOptions = [
                        "noatime"
                        "compress=zstd"
                      ];
                    };
                    "@nix" = {
                      mountpoint = "/nix";
                      mountOptions = [
                        "noatime"
                        "compress=zstd"
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
        content = {
          type = "gpt";
          partitions = {
            luks = {
              size = "100%";
              content = {
                type = "luks";
                name = "cryptdata";
                setting = {
                  allowDiscards = true;
                };
                content = {
                  type = "filesystem";
                  format = "btrfs";
                  extraArgs = [ "-f" ];
                  subvolumes = {
                    "@persisthome" = {
                      mountpoint = "/persisthome";
                      mountOptions = [
                        "noatime"
                        "compress=zstd"
                      ];
                    };
                    "@games" = {
                      mountpoint = "/games";
                      mountOptions = [
                        "noatime"
                        "compress=zstd"
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
  };
}
