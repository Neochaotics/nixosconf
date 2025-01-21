{
  lib,
  config,
  ...
}:
let
  cfg = config.cmodule.home.quinno.bash;
in
{
  options.cmodule.home.quinno.bash = {
    enable = lib.mkEnableOption "Enable configuration";
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
