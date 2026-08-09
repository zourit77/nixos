{ config, pkgs, lib, modulesPath, ... }:
{
  # Import du module SD aarch64 générique, qui contient déjà beaucoup
  # de configuration nécessaire pour Raspberry Pi aarch64.
  imports = [
    "${modulesPath}/installer/sd-card/sd-image-aarch64.nix"
  ];

  boot.loader.grub.enable = false;
  boot.loader.generic-extlinux-compatible.enable = true;

  # Timezone, keymap, etc.
  time.timeZone = "Europe/Paris";
  console.keyMap = "fr";

  # Optionnel : Wi-Fi basique
  networking.wireless = {
    enable = true;
    networks = {
      "ton_SSID".psk = "motdepassewifi";
    };
  };

  # Optionnel : ne pas compresser l'image pour build plus simple
  sdImage.compressImage = false;
}
