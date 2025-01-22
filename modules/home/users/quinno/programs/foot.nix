{
  lib,
  config,
  ...
}:
let
  cfg = config.cm.home.users.quinno.programs.foot;
in
{
  options.cm.home.users.quinno.programs.foot = {
    enable = lib.mkEnableOption "Enable foot terminal configuration";
  };

  config = lib.mkIf cfg.enable {
    programs.foot = {
      enable = true;
      settings = {
        main = {
          term = "xterm-256color";

          font = "Fira Code:size=11";
          dpi-aware = "yes";
        };
        mouse = {
          hide-when-typing = "yes";
        };
      };
    };
  };
}
