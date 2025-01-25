#sudo nix run 'github:nix-community/disko/latest#disko-install' --extra-experimental-features 'nix-command flakes' -- --flake ~/megaflake#libvirt --disk primary /dev/disk/by-id/virtio-CT1000P5PSSD8_22343AC3C7AD --disk secondary /dev/disk/by-id/virtio-CT2000P5PSSD8_23113F244794
sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko/latest -- --mode destroy,format,mount ~/megaflake/hosts/libvirt/disko.nix