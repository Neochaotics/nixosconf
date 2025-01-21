{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.cmodule.nixos.common.pipewire;
in
{

  options.cmodule.nixos.common.pipewire = {
    enable = lib.mkEnableOption "Enable configuration";
  };

  config = lib.mkIf cfg.enable {
    boot = lib.mkIf config.services.pipewire.enable {
      kernelParams = [ "threadirqs" ];
    };

    environment.systemPackages = with pkgs; [
      lxqt.pavucontrol-qt
      qpwgraph
      playerctl
      alsa-utils
    ];

    services = {
      pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = lib.mkForce config.hardware.graphics.enable32Bit;
        pulse.enable = true;
        jack.enable = false;
        wireplumber = {
          enable = true;
          extraConfig.bluetoothEnhancements = {
            "monitor.bluez.properties" = {
              "bluez5.enable-sbc-xq" = true;
              "bluez5.enable-msbc" = true;
              "bluez5.enable-hw-volume" = true;
              "bluez5.roles" = [
                "hsp_hs"
                "hsp_ag"
                "hfp_hf"
                "hfp_ag"
              ];
            };
          };
          extraConfig.pipewire."92-low-latency" = {
            "context.properties" = {
              "default.clock.rate" = 48000;
              "default.clock.quantum" = 32;
              "default.clock.min-quantum" = 32;
              "default.clock.max-quantum" = 32;
            };
          };
        };
      };
      udev.extraRules = ''
        # Expose important timers the members of the audio group
        KERNEL=="rtc0", GROUP="audio"
        KERNEL=="hpet", GROUP="audio"
        # Allow users in the audio group to change cpu dma latency
        DEVPATH=="/devices/virtual/misc/cpu_dma_latency", OWNER="root", GROUP="audio", MODE="0660"
      '';
    };
    # Allow members of the "audio" group to set RT priorities
    security = {
      pam.loginLimits = [
        {
          domain = "@audio";
          item = "memlock";
          type = "-";
          value = "unlimited";
        }
        {
          domain = "@audio";
          item = "rtprio";
          type = "-";
          value = "99";
        }
        {
          domain = "@audio";
          item = "nofile";
          type = "soft";
          value = "99999";
        }
        {
          domain = "@audio";
          item = "nofile";
          type = "hard";
          value = "99999";
        }
      ];
      rtkit.enable = true;
    };
  };

}
