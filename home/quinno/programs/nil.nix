{
  pkgs,
  config,
  ...
}:let

    pkgsUnstable = import <nixpkgs-unstable> {};

  in
  {

  home.packages = with pkgsUnstable; [
    nil
  ];

}