{ config, pkgs, ... }:

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
    ./ntp.nix
    ./nvidia.nix
    ./opengl.nix
    ./packages.nix
    ./polkit.nix
    ./services.nix
    ./syncthing.nix
    ./vm.nix
  ];
}
