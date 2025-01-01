{
  wayland.windowManager.hyprland.settings = {
    monitor = [
      "DP-2, 2560x1440@180, auto, 1"
      "HDMI-A-1,1920x1080@75, auto-right, 1, transform, 3"
      "HDMI-A-1, addreserved, 0, 650, 0, 75"
      "DP-5, 1920x1080@60, auto-up, 1"
    ];

    workspace = [
      "1, monitor:DP-2"
      "2, monitor:DP-2"
      "3, monitor:DP-2"
      "4, monitor:DP-2"
      "5, monitor:HDMI-A-1"
      "6, monitor:HDMI-A-1"
      "7, monitor:HDMI-A-1"
      "8, monitor:HDMI-A-1"
      "9, monitor:DP-5"
      "10, monitor:DP-5"
      "name:G, on-created-empty:uwsm app -- steam.desktop:Library, monitor:DP-2"
    ];
  };
}
