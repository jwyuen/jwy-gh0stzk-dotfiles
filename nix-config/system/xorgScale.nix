{ config, lib, host, ... }:

let inherit (import ../hosts/${host}/options.nix) xrandrScale; in
lib.mkIf ("${xrandrScale}" != null && "${host}" == "nix-lappy") {
  services.xserver.displayManager.sessionCommands = ''
    xrandr --output eDP-1 --scale ${xrandrScale} --mode 2880x1800
  '';
}
