{
  # Boot Configuration
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
      "virtio_net"
      "virtio_pci"
      "virtio_mmio"
      "virtio_blk"
      "virtio_scsi"
      "9p"
      "9pnet_virtio"
    ];
    kernelModules = [
      "kvm-amd"
      "virtio_balloon"
      "virtio_console"
      "virtio_rng"
      "virtio_gpu"
    ];
  };

  services.spice-vdagentd.enable = true;

  # Filesystem Configuration
  #fileSystems = {
  #  "/" = {
  #    device = "/dev/disk/by-uuid/564fbf74-38de-42a7-ba67-7d993df8b611";
  #    fsType = "ext4";
  #  };
  #  "/boot" = {
  #    device = "/dev/disk/by-uuid/2A41-5358";
  #    fsType = "vfat";
  #    options = [
  #      "fmask=0077"
  #      "dmask=0077"
  #    ];
  #  };
  #};
}
