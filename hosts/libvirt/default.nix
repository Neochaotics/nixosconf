{ lib, modulesPath, ... }:

{
  imports = [
    (modulesPath + "/profiles/qemu-guest.nix")
    ../../modules/nixos/common/temp-misc.nix
    ../../modules/nixos
  ];

  users.users.quinno = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    description = "Quinn O";
  };
  services = {
    getty.autologinUser = "quinno";
    getty.autologinOnce = true;
    spice-vdagentd.enable = true;
  };

  home-manager.users.quinno = import ../../modules/home/quinno;

  system.stateVersion = "24.11";
  cmodule = {
    nixos = {
      pkgs = {
        hyprland.enable = true;
        sudo.enable = true;
      };
      common = {
        home-manager.enable = true;
        nix.enable = true;
      };
    };
  };

  boot = {
    initrd.availableKernelModules = [
      "xhci_pci"
      "ohci_pci"
      "ehci_pci"
      "virtio_pci"
      "ahci"
      "usbhid"
      "sr_mod"
      "virtio_blk"
    ];
    kernelModules = [ "kvm-amd" ];
  };

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/564fbf74-38de-42a7-ba67-7d993df8b611";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/2A41-5358";
    fsType = "vfat";
    options = [
      "fmask=0077"
      "dmask=0077"
    ];
  };

  networking.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

}
