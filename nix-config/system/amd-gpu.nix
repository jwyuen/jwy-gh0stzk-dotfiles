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
lib.mkIf ("${gpuType}" == "amd") {
  systemd.tmpfiles.rules = [
    "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}"
  ];
  services.xserver.enable = true;
  services.xserver.videoDrivers = [ "amdgpu" ];
}
