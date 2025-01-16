{ lib, config, ... }:
let
  cfg = config.cmodule.nixos.pkgs.hyprland;
in
{
  options.cmodule.nixos.pkgs.hyprland = {
    enable = lib.mkEnableOption "Enable configuration";
  };

  config = lib.mkIf cfg.enable {
    programs.uwsm = {
      enable = true;
    };
    programs.hyprland = {
      enable = true;
      withUWSM = true;
    };
  };
}
