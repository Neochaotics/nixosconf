{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.cmodule.home.quinno.desktops.hyprland;
in
{
  imports = [
    ./general.nix
    ./appearance.nix
    ./input.nix
    ./misc.nix

    ./bindings.nix
    ./monitors.nix
    ./windowrules.nix
  ];

  options.cmodule.home.quinno.desktops.hyprland = {
    enable = lib.mkEnableOption "Enable Quinn's Hyprland's configuration";
  };

  config = lib.mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      enable = true;
      systemd.enable = false;
      xwayland.enable = true;
    };

    programs.bash.initExtra = ''
      if uwsm check may-start; then
        exec uwsm start -S hyprland-uwsm.desktop
      fi
    '';

    xdg.portal = {
      enable = true;
      extraPortals = [
        pkgs.xdg-desktop-portal-hyprland
        pkgs.xdg-desktop-portal-gtk
      ];
      config = {
        hyprland = {
          default = [
            "hyprland"
            "gtk"
          ];
        };
      };
    };
  };
}
