{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.cmodule.nixos.pkgs.steam;
in
{
  options.cmodule.nixos.pkgs.steam = {
    enable = lib.mkEnableOption "Enable configuration";
  };

  config = lib.mkIf cfg.enable {
    nixpkgs.config.allowUnfreePredicate =
      pkg:
      builtins.elem (lib.getName pkg) [
        "steam"
        "steam-unwrapped"
      ];
    programs.steam = {
      enable = true;
      extraCompatPackages = with pkgs; [
        proton-ge-bin
      ];
      extraPackages = with pkgs; [
        gamescope
        mangohud
        gamemode
      ];
      protontricks.enable = true;
      gamescopeSession = {
        enable = true;

      };
    };
  };
}
