{
  lib,
  ...
}:
{
  imports = [
    ./desktops/hyprland
    ./bash.nix
    ./browsers.nix
    ./common.nix
    ./git.nix
    ./media.nix
    ./xdg.nix
    ./term.nix
  ];
  home = {
    stateVersion = "24.05";
    username = "quinno"; # ${hostSpec.username};
    homeDirectory = lib.mkForce "/home/quinno";
  };
  programs.home-manager.enable = true;

  quinno.desktops.hyprland.enable = true;
}
