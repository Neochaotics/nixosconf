{ inputs, ... }:
{
  imports = [

  ];
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "bk";
    users = {
      quinno = import ./quinno;
    };
    extraSpecialArgs = { inherit inputs; };
  };
}
