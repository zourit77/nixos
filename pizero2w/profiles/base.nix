{ config, pkgs, lib, ... }:
{
  system.stateVersion = "23.11";

  networking.hostName = "nixos-pizero2w-homelab";

  # DHCP simple sur interface principale (éthernet / wifi via hardware module)
  networking.useDHCP = true;

  # Utilisateur admin simple
  users.users = {
    tux = {
      isNormalUser = true;
      password = "Dreamoflight77!!";  # à changer ensuite !
      extraGroups = [ "wheel" ];
    };
  };

  # Autoriser sudo pour le groupe wheel
  security.sudo.enable = true;
  security.sudo.wheelNeedsPassword = true;

  # SSH
  services.openssh.enable = true;
  services.openssh.settings.PasswordAuthentication = true;

  # Paquets de base
  environment.systemPackages = with pkgs; [
    vim
    git
    htop
  ];
}
