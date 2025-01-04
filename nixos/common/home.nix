{ inputs, pkgs, ... }:
{
  users.users.quinno = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    description = "Quinn O";
  };
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.backupFileExtension = "bk";
  home-manager.users.quinno = import ../../home/quinno;
  home-manager.extraSpecialArgs = { inherit pkgs inputs; };
  services.getty.autologinUser = "quinno";
  services.getty.autologinOnce = true;
}
