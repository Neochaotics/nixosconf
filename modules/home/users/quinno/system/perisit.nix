{
  lib,
  config,
  ...
}:
let
  cfg = config.cmodule.home.quinno.persist;
in
{
  options.cmodule.home.quinno.persist = {
    enable = lib.mkEnableOption "Enable configuration";
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
