commande à lancer pour le build :

nix build '.#nixosConfigurations.pi-zero2.config.system.build.sdImage' \
  --extra-experimental-features 'nix-command flakes'
  
  gravure sd card :
  
  sudo dd if=result/nixos-sd-image-*-aarch64-linux.img of=/dev/sdX \
  bs=4M status=progress conv=fsync
