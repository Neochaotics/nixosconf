{ lib, config, ... }:
let
  cfg = config.quinno.desktops.hyprland;
in
{
  imports = [
    ./variables/hyprgen.nix
    ./variables/hyprappearance.nix
    ./variables/hyprinput.nix
    ./variables/hyprmisc.nix

    ./keywords/hyprbinds.nix
    ./keywords/hyprspaces.nix
    ./keywords/hyprrules.nix
  ];

  options.quinno.desktops.hyprland = {
    enable = lib.mkEnableOption "Enable Quinn's Hyprland's configuration";
  };

  config = lib.mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      enable = true;
      systemd.enable = false;
      xwayland.enable = true;
    };
  };
}
