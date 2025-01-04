{ inputs,
  lib,
  ...
}: {
  imports = lib.flatten [
    inputs.disko.nixosModules.disko
    inputs.impermanence.nixosModules.impermanence
    inputs.home-manager.nixosModules.home-manager
    ./pkgs/sudo.nix
    ./pkgs/hyprland.nix
    ./common/nix.nix
    ./common/home.nix
  ];
}
