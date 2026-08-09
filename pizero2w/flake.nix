{
  description = "NixOS RPi Zero 2 W (Docker)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
  };

  outputs = { self, nixpkgs, ... }:
  let
    system = "aarch64-linux";
    lib = nixpkgs.lib;
  in {
    nixosConfigurations.pi-zero2 = lib.nixosSystem {
      inherit system;
      modules = [
        ./hardware-raspberrypi-zero2.nix
        ./profiles/base.nix
        ./extra-config.nix
        ./maintenance.nix
      ];
    };
  };
}
