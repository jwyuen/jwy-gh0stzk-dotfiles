{
  config,
  lib,
  pkgs,
  host,
  ...
}:

let
  inherit (import ../../hosts/${host}/options.nix) theKernel;
in
lib.mkIf (theKernel == "zen") {
  boot.kernelPackages = pkgs.linuxKernel.kernels.linux_zen;
}
