{ inputs
, pkgs
, ...
}:{
  programs.uwsm.enable = true;
  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };
}