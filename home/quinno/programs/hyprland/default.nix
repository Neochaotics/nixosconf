{ inputs
, outputs
, config
, lib
, pkgs
, ...
}: {
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      bind =
        [
          "SUPER, F, exec, firefox"
        ]
        };
      extraConfig = builtins.readFile ./hyprland.conf;
    };
  }