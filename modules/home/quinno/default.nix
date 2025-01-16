{
  lib,
  ...
}:
{
  imports = [
    ./programs
    ./desktops/hyprland
    ./shells/bash.nix
  ];
  home = {
    stateVersion = "24.05";
    username = "quinno"; # ${hostSpec.username};
    homeDirectory = lib.mkForce "/home/quinno";
  };
  programs.home-manager.enable = true;

  quinno.desktops.hyprland.enable = true;
}
