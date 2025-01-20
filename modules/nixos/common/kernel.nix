{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.cmodule.nixos.common.kernel;
in
{
  options.cmodule.nixos.common.kernel = {
    enable = lib.mkEnableOption "Enable configuration";
  };

  config = lib.mkIf cfg.enable {
    boot.kernelPackages = pkgs.linuxPackages_zen;
    services.scx.enable = true; # by default uses scx_rustland scheduler
  };
}
