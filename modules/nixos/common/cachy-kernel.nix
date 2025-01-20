{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.cmodule.nixos.common.cachy-kernel;
in
{
  options.cmodule.nixos.common.cachy-kernel = {
    enable = lib.mkEnableOption "Enable configuration";
  };

  config = lib.mkIf cfg.enable {
    boot.kernelPackages = pkgs.linuxPackages_cachyos;
    services.scx.enable = true; # by default uses scx_rustland scheduler
  };
}
