{ lib, ... }:{
  imports = [
    ./browsers.nix
    ./common.nix
    ./git.nix
    ./media.nix
    ./xdg.nix
  ];

  home.homeDirectory = lib.mkForce "/home/quinno";
}
