{ pkgs, config, lib, host, ... }:

let inherit (import ../hosts/${host}/options.nix) bspwm; in
lib.mkIf (bspwm == true) {
  services.xserver.windowManager.bspwm.enable = true;
}
