{ lib, config, ... }:
let
  cfg = config.cm.nixos.packages.hyprland;
in
{
  options.cm.nixos.packages.hyprland = {
    enable = lib.mkEnableOption "Enable Hyprland with UWSM";
  };

  config = lib.mkIf cfg.enable {
    programs = {
      uwsm.enable = true;
      hyprland = {
        enable = true;
        withUWSM = true;
      };
    };
  };
}
