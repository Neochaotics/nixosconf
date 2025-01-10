{
  imports = [
    <nixpkgs/nixos/modules/profiles/minimal.nix>
    <nixpkgs/nixos/modules/profiles/hardened.nix>
  ];
  boot.initrd.includeDefaultModules = false;
  disabledModules =
    [ <nixpkgs/nixos/modules/profiles/all-hardware.nix>
      <nixpkgs/nixos/modules/profiles/base.nix>
    ];

  # disable useless software
  environment.defaultPackages = [];
}
