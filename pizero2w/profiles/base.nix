{ config, pkgs, lib, ... }:
{
  system.stateVersion = "23.11";

  networking.hostName = "pi-zero2";
  networking.useDHCP = true;

  users.users.tonnomutilisateur = {
    isNormalUser = true;
    password = "motdepasseutilisateur";  # change-le ensuite
    extraGroups = [ "wheel" "docker" ];
  };

  security.sudo.enable = true;
  security.sudo.wheelNeedsPassword = true;

  services.openssh.enable = true;
  services.openssh.settings.PasswordAuthentication = true;

  virtualisation.docker.enable = true;

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    vim
    git
    htop
    curl
    neofetch
    docker
    docker-compose
    openssh
  ];
}
