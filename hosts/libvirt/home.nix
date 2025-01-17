{
  imports = [
    ../../modules/home/quinno
  ];

  home = {
    stateVersion = "24.05";
    username = "quinno";
    homeDirectory = "/home/quinno";
  };

  cmodule.home = {
    quinno = {
      xdg.enable = true;
      git.enable = true;
      foot.enable = true;
      common.enable = true;
      bash.enable = true;
      desktops.hyprland.enable = true;
    };
  };
}
