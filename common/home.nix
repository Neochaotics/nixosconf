{ inputs
, outputs
, config
, lib
, pkgs
, ...
}:{
  users.users.quinno = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    description = "Quinn O";
  };
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.backupFileExtension = "bk";
  home-manager.users.quinno = import ../home/quinno; #${hostSpec.username} = import ../home/${hostSpec.username};
  home-manager.extraSpecialArgs = {
    inherit pkgs inputs;
    hostSpec = config.hostSpec;
  };
}
