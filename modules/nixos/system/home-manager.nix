{
  inputs,
  lib,
  config,
  ...
}:
let
  cfg = config.cm.nixos.system.home-manager;
in
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  options.cm.nixos.system.home-manager = {
    enable = lib.mkEnableOption "Enable home-manager configuration for system";
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
