{ modulesPath, ... }:
{
  imports = [
    (modulesPath + "/profiles/minimal.nix")
  ];
  boot.initrd.includeDefaultModules = false;
  disabledModules = [
    (modulesPath + "/profiles/all-hardware.nix")
    (modulesPath + "/profiles/base.nix")
  ];
}
