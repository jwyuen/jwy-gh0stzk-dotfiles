{
  pkgs,
  config,
  lib,
  host,
  ...
}:

let
  inherit (import ../hosts/${host}/options.nix) secureboot;
in
{

  # Bootloader
  boot.loader.systemd-boot = lib.mkMerge [
    (lib.mkIf (secureboot == true) {
      enable = lib.mkForce false;
    })
    (lib.mkIf (secureboot == false) {
      enable = true;
    })
  ];

  boot.lanzaboote = lib.mkIf (secureboot == true) {
    enable = true;
    pkiBundle = "/var/lib/sbctl";
  };

  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernel.sysctl = {
    "vm.max_map_count" = 2147483642;
    "vm.swappiness" = 10;
  };

  boot.tmp.useTmpfs = true;
  boot.tmp.tmpfsSize = "25%";

  # This is for OBS Virtual Cam Support - v4l2loopback setup
  boot.kernelModules = [ "v4l2loopback" ];
  boot.extraModulePackages = [ config.boot.kernelPackages.v4l2loopback ];
}
