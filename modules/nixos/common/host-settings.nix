{
  lib,
  config,
  ...
}:
let
  cfg = config.cmodule.nixos.common.host-settings;
in
{

  options.cmodule.nixos.common.host-settings = {
    enable = lib.mkEnableOption "Configure Hosts with global settings";
    output_level = lib.mkOption { type = lib.types.str; };
  };

  config = lib.mkIf cfg.enable {
    output_level = lib.mkDefault "silent";
  };
}
