{ modulesPath, ... }:
{
  imports = [
    (modulesPath + "/profiles/minimal.nix")
    #(modulesPath + "/profiles/hardened.nix")

  ];
  boot.initrd.includeDefaultModules = false;
  disabledModules = [
    (modulesPath + "/profiles/all-hardware.nix")
    (modulesPath + "/profiles/base.nix")
  ];

  # disable useless software
  environment.defaultPackages = [ ];
}
