{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.cmodule.nixos.common.boot;
in
{
  options.cmodule.nixos.common.boot = {
    enable = lib.mkEnableOption "Enable configuration";
  };

  config = lib.mkIf cfg.enable {
    boot = {
      plymouth = {
        enable = true;
        #logo = "";
        theme = "hexagon_2";
        themePackages = with pkgs; [
          # By default we would install all themes
          (adi1090x-plymouth-themes.override {
            selected_themes = [ "hexagon_2" ];
          })
        ];
      };
      kernelPackages = pkgs.linuxPackages_zen;
      loader = {
        timeout = 0;
        systemd-boot = {
          editor = false;
          enable = true;
          configurationLimit = lib.mkDefault 10;
        };
        efi.canTouchEfiVariables = true;
      };
      kernelParams = [
        "quiet"
        "splash"
        "boot.shell_on_fail"
        "loglevel=3"
        "systemd.show_status=false"
        "rd.udev.log_level=3"
        "udev.log_priority=3"
        "vga=current"
      ];
      consoleLogLevel = 0;
      initrd.verbose = false;
    };
    services.scx.enable = true; # by default uses scx_rustland scheduler
  };
}
