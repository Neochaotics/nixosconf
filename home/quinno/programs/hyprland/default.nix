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
    extraConfig = builtins.readFile ./hyprconf.conf;
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
