{
  inputs,
  host,
  ...
}:
let
  # Import the host-specific variables.nix
  vars = import ../hosts/${host}/variables.nix;
in
{

  imports = [
    ./amd-gpu.nix
    ./appimages.nix
    ./autorun.nix
    ./boot.nix
    ./bspwm.nix
    ./kde.nix
    ./displaymanager.nix
    ./hwclock.nix
    ./intel-amd.nix
    ./intel-gpu.nix
    ./intel-nvidia.nix
    ./kernel.nix
    ./logitech.nix
    ./maccel.nix
    ./ntp.nix
    ./nvidia.nix
    ./opengl.nix
    ./packages.nix
    ./polkit.nix
    ./power-profiles-daemon.nix
    ./security.nix
    ./services.nix
    ./steam.nix
    ./stylix.nix
    ./swap.nix
    ./syncthing.nix
    ./virtualisation.nix
    ./vm.nix
    ./xorgScale.nix

    inputs.stylix.nixosModules.stylix
  ];
}
