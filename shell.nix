{
  pkgs ? import <nixpkgs> { },
  config,
}:

pkgs.mkShell {
  name = "nixosconf";
  packages = [
    pkgs.nil
    config.treefmt.build.wrapper
  ];
}
