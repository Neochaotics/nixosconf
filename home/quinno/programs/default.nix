{ lib, ... }:{
  imports = [
    ./browsers.nix
    ./common.nix
    ./git.nix
    ./media.nix
    ./xdg.nix
    ./hyprland
  ];

  home.homeDirectory = lib.mkForce "/home/quinno";
}
