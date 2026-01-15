{
  pkgs,
  config,
  lib,
  host,
  ...
}:

let
  inherit (import ../hosts/${host}/options.nix) kde;
in
lib.mkIf (kde == true) {
  services.desktopManager.plasma6.enable = true;
}
