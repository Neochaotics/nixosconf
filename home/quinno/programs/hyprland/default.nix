{ inputs
, outputs
, config
, lib
, pkgs
, ...
}: {
  wayland.windowManager.hyprland = {
    enable = true;
    withSystemd = false;
    settings = {
      bind =
        [
          "SUPER, F, exec, firefox"
        ];
        };
      extraConfig = builtins.readFile ./hyprland.conf;
    };
  }