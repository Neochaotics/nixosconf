{ config, ... }:
{
  programs.bash = {
    enable = true;
    enableCompletion = true;
    historyControl = [ "ignoreboth" ];
    historyFile = "${config.home.homeDirectory}/.bash_history";
    historyFileSize = 1000;
    historyIgnore = [
      "clear"
      "exit"
    ];
    historySize = 1000;
    initExtra =
      if config.wayland.windowManager.hyprland.enable then
        "
      if uwsm check may-start; then
        exec uwsm start -S hyprland-uwsm.desktop
      fi
    "
      else
        "";
  };
}
