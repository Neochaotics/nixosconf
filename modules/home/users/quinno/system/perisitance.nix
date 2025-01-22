{
  lib,
  config,
  ...
}:
let
  cfg = config.cm.home.users.quinno.system.persistance;
in
{
  options.cm.home.users.quinno.system.persistance = {
    enable = lib.mkEnableOption "Enable persistence configuration for quinno user";
  };

  config = lib.mkIf cfg.enable {
    home.persistence = {
      "/persisthome" = {
        directories = [
          "Downloads"
          "Music"
          "Pictures"
          "Documents"
          "Videos"
          ".gnupg"
          ".ssh"
          ".local/share/keyrings"
          ".local/share/direnv"
        ];
      };
      "/games" = {
        directories = [
          {
            directory = ".local/share/Steam";
            method = "symlink";
          }
        ];
      };
    };
  };
}
