{ inputs
, pkgs
, ...
}: {
  programs.uwsm = {
    enable = true;
  };
  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };

  programs.bash.initExtra = ''
    if uwsm check may-start; then
      exec uwsm start -S hyprland-uwsm.desktop
    fi
  '';
}
