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
  };
}
