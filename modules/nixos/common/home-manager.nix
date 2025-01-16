{
  inputs,
  lib,
  config,
  ...
}:
let
  cfg = config.cmodule.nixos.common.home-manager;
in
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  options.cmodule.nixos.common.home-manager = {
    enable = lib.mkEnableOption "Enable configuration";
  };

  config = lib.mkIf cfg.enable {
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      backupFileExtension = "bk";
      extraSpecialArgs = { inherit inputs; };
    };
  };
}
