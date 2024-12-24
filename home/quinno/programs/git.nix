{
  pkgs,
  ...
}: {
  home.packages = [pkgs.gh];

  programs.git = {
    enable = true;

    userName = "Neochaotics";
    userEmail = "neochaotics@pm.me";
  };
}
