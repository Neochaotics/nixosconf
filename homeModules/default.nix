{inputs, ...}:{
  home-manager = {
    enable = true;
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "bk";
    users = {
      quinno = import ../../home/quinno;
    };
    extraSpecialArgs = { inherit inputs; };
  };
}
