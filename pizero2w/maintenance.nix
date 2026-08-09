{ config, pkgs, lib, ... }:

{
  ##########################################################################
  # Mises à jour automatiques
  ##########################################################################

  system.autoUpgrade = {
    enable = true;
    channel = "https://channels.nixos.org/nixos-26.05";
    dates = "*-*-* 18:00:00";
    randomizedDelaySec = "45min";
    persistent = true;
    operation = "boot";
    allowReboot = false;
    flags = [ ];
  };

  ##########################################################################
  # Nettoyage des anciennes générations
  ##########################################################################

  systemd.services.nixos-generations-cleanup = {
    description = "Nettoyage des anciennes générations NixOS";
    path = [ pkgs.nix ];

    serviceConfig = {
      Type = "oneshot";
    };

    script = ''
      set -euo pipefail

      echo "Conservation des 5 dernières générations système..."
      nix-env \
        --profile /nix/var/nix/profiles/system \
        --delete-generations +5

      echo "Nettoyage des données Nix âgées de plus de 7 jours..."
      nix-collect-garbage --delete-older-than 7d
    '';
  };

  systemd.timers.nixos-generations-cleanup = {
    description = "Nettoyage quotidien des générations NixOS";
    wantedBy = [ "timers.target" ];

    timerConfig = {
      OnCalendar = "*-*-* 19:00:00";
      RandomizedDelaySec = "30min";
      Persistent = true;
      Unit = "nixos-generations-cleanup.service";
    };
  };

  ##########################################################################
  # Reboot hebdomadaire (samedi 04h00)
  ##########################################################################

  systemd.services."weekly-reboot" = {
    description = "Redémarrage hebdomadaire du système";
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.systemd}/bin/systemctl reboot";
    };
  };

  systemd.timers."weekly-reboot" = {
    description = "Timer de redémarrage hebdomadaire";
    wantedBy = [ "timers.target" ];

    timerConfig = {
      OnCalendar = "Sat *-*-* 04:00:00";
      Persistent = true;
      Unit = "weekly-reboot.service";
    };
  };

  ##########################################################################
  # Journald : conserver les logs 30 jours max
  ##########################################################################

  services.journald = {
    extraConfig = ''
      [Journal]
      MaxRetentionSec=30day
    '';
  };
}
