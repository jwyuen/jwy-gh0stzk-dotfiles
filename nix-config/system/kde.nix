{ pkgs, config, lib, host, ... }:

let inherit (import ../hosts/${host}/options.nix) kde; in
lib.mkIf (kde == true) {
  services.xserver.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;
  services.xserver.displayManager.defaultSession = "plasma";
  #services.xserver.displayManager.defaultSession = "plasmax11";
}
