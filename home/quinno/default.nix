{ lib,
  ...
}:{
  imports = [
    ./programs
  ];
  home.stateVersion = "24.05";
  home.username = "quinno"; #${hostSpec.username};
  home.homeDirectory = lib.mkForce "/home/quinno";
  programs.home-manager.enable = true;
}
