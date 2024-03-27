{ pkgs, config, lib, ... }:

let inherit (import ../../options.nix) bspwm; in
lib.mkIf (bspwm == true) {
  services.xserver.enable = true;
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.windowManager.bspwm.enable = true;
}
