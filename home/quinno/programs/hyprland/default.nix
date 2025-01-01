{ inputs
, outputs
, config
, lib
, pkgs
, ...
}: {
  imports = [
    ./variables/hyprgen.nix
    ./variables/hyprappearance.nix
    ./variables/hyprinput.nix
    ./variables/hyprmisc.nix

    ./keywords/hyprbinds.nix
    ./keywords/hyprspaces.nix
    ./keywords/hyprrules.nix
  ];
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = false;
    xwayland.enable = true;
  };
}
