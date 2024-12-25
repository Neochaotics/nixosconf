{
  imports = [
    ./programs
  ];
  home.stateVersion = "24.05";
  home.username = "quinno"; #${hostSpec.username};
  home.homeDirectory = "/home/quinno"; #${hostSpec.username}";
  programs.home-manager.enable = true;
}
