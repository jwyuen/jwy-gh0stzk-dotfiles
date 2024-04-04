{ pkgs, config, lib, ... }:

let inherit (import ../../options.nix) bspwm; in
lib.mkIf (bspwm == true) {
  services.xserver.windowManager.bspwm.enable = true;
}
