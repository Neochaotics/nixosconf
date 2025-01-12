{
  pkgs ? import <nixpkgs> { },
}:

pkgs.mkShell {
  packages = with pkgs; [
    nil
    nixfmt-rfc-style
    statix
  ];
}
