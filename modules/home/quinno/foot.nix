{
  lib,
  config,
  ...
}:
let
  cfg = config.cmodule.home.quinno.foot;
in
{
  options.cmodule.home.quinno.foot = {
    enable = lib.mkEnableOption "Enable configuration";
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
