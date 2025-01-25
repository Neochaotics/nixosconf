#! /bin/bash
sudo nix run 'github:nix-community/disko/latest#disko-install' --extra-experimental-features 'nix-command flakes' -- --flake https://github.com/Neochaotics/megaflake#libvirt --disk primary /dev/disk/by-id/virtio-CT1000P5PSSD8_22343AC3C7AD --disk secondary /dev/disk/by-id/virtio-CT2000P5PSSD8_23113F244794
