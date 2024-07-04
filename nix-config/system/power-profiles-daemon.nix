{ config, lib, host, ... }:

let inherit (import ../hosts/${host}/options.nix) powerprofiles; in
lib.mkIf (powerprofiles == true) {
  services.power-profiles-daemon.enable = true;
}
