{ pkgs, config, lib, ... }:

let inherit (import ../../options.nix) kde; in
lib.mkIf (kde == true) {
  services.xserver.enable = true;
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;
  services.xserver.displayManager.defaultSession = "plasma";
  #services.xserver.displayManager.defaultSession = "plasmax11";
}
