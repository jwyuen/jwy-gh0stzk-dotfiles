{ host, ... }:
let
  inherit (import ../../hosts/${host}/options.nix) animChoice;
in
{
  imports = [
    # animChoice
    ./binds.nix
    ./env.nix
    ./exec-once.nix
    ./hypridle.nix
    ./hyprland.nix
    ./hyprlock.nix
    ./pyprland.nix
    ./windowrules.nix
  ];
}
