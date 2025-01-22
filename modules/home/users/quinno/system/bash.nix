{
  lib,
  config,
  ...
}:
let
  cfg = config.cm.home.users.quinno.system.bash;
in
{
  options.cm.home.users.quinno.system.bash = {
    enable = lib.mkEnableOption "Enable bash configuration and settings";
  };

  config = lib.mkIf cfg.enable {
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
  };
}
