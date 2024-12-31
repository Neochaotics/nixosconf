{ inputs
, outputs
, config
, lib
, pkgs
, ...
}: {
  #wayland.windowManager.hyprland.extraConfig
  wayland.windowManager.hyprland = {
    enable = true;
    # plugins = with pkgs; [ hyprlandPlugins.hyprtrails ];
    extraConfig = builtins.readFile ./hyprland.conf;
    systemd.enable = false;
    xwayland.enable = true;
  };
  # https://github.com/hyprwm/hyprland-wiki/issues/409
  # https://github.com/nix-community/home-manager/pull/4707
  xdg.portal = {
    config = {
      common = {
        default = [ "hyprland" ];
        #"org.freedesktop.impl.portal.Secret" = [ "gnome-keyring" ];
      };
    };
    configPackages = [ config.wayland.windowManager.hyprland.package ];
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal
      pkgs.xdg-desktop-portal-hyprland
    ];
    xdgOpenUsePortal = true;
  };
}
