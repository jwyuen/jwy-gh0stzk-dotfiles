{
  pkgs,
  config,
  lib,
  host,
  ...
}:

let
  inherit (import ../hosts/${host}/options.nix) swapPartUUID swapLUKSID;
in

lib.mkIf (swapPartUUID != "") {
  boot.kernel.sysctl = {
    "vm.swappiness" = 10;
  };
  boot.initrd.luks.devices.${swapLUKSID} = {
    device = "/dev/disk/by-partuuid/${swapPartUUID}";
    # SSD optimisations
    allowDiscards = true;
    bypassWorkqueues = true;
  };
  swapDevices = [
    {
      device = "/dev/disk/by-partuuid/${swapPartUUID}";
      randomEncryption.enable = true;
    }
  ];
  boot.resumeDevice = "/dev/disk/by-partuuid/${swapPartUUID}";

}
