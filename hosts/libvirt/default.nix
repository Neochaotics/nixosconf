{ lib, ... }:
let
  username = "quinno";
  formatUsername =
    name:
    lib.strings.stringAsChars (
      c:
      if c == builtins.substring ((builtins.stringLength name) - 1) 1 name then
        " ${lib.strings.toUpper c}"
      else if c == (builtins.substring 0 1 name) then
        lib.strings.toUpper c
      else
        c
    ) name;
in
{
  imports = [
    ./hardware.nix
    ../../modules/nixos
  ];

  # User Configuration
  users.users.${username} = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    description = formatUsername username;
  };
  home-manager.users.${username} = import ./home.nix;

  # Service Configuration
  services = {
    getty = {
      autologinUser = username;
      autologinOnce = true;
    };
    spice-vdagentd.enable = true;
  };

  # System Configuration
  system.stateVersion = "24.11";
  networking.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  # Custom Module Configuration
  cmodule.nixos = {
    pkgs = {
      hyprland.enable = true;
      sudo.enable = true;
      steam.enable = true;
    };
    common = {
      home-manager.enable = true;
      nix.enable = true;
      cachy-sysctl.enable = true;
    };
  };
}
