{ config, pkgs, lib, ... }:
{
  networking.firewall.enable = false;

  nixpkgs.config.allowUnfree = true;

  # Ajouter éventuellement des paquets supplémentaires ici
  environment.systemPackages = with pkgs; [
    openssh
    docker
    docker-compose
  ];

  services.openssh.enable = true;
}
