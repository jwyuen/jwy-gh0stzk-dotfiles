{
  pkgs,
  config,
  lib,
  host,
  ...
}:

let
  inherit (import ../hosts/${host}/options.nix) gpuType;
in
lib.mkIf (gpuType == "nvidia") {
  # GPU overclock/tuning tool (like MSI Afterburner)
  services.lact = {
    enable = true;
    # settings = {
    #
    # };
  };
}
