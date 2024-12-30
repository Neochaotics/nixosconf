{ inputs
, outputs
, config
, lib
, pkgs
, ...
}: {
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = false;
    extraConfig = builtins.readFile ./hyprland.conf;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
  };
}
