{
  imports = [
    ./home-manager.nix
    ./nix.nix
    ./minimal.nix # not a real module
    ./temp-misc.nix # temp
    ./cachy-sysctl.nix
    ./cachy-kernel.nix
  ];
}