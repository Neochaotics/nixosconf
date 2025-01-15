{ inputs, pkgs, ... }:
{
  home-manager = {
    enable = true;
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "bk";
    #users = {
    #  quinno = import ../../home/quinno;
    #};
    users =
      let
        userDirs = builtins.attrNames (builtins.readDir ../home);
        mkUserConfig = username: import ../home/${username} { inherit username; };
      in
      pkgs.lib.genAttrs userDirs mkUserConfig;
    extraSpecialArgs = { inherit inputs; };
  };
}
