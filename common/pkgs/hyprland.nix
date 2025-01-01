{ inputs
, pkgs
, ...
}: {
  programs.uwsm = {
    enable = true;
  };
  programs.hyprland = {
    enable = true;
    withUWSM = true; # recommended for most users
    xwayland.enable = true; # Xwayland can be disabled.
  };

  services.displayManager.enable = true;
}
