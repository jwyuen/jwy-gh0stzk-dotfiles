{
  pkgs,
  config,
  lib,
  inputs,
  ...
}:

{

  imports = [
    inputs.noctalia.nixosModules.default
  ];

  # List services that you want to enable:
  services.openssh.enable = true;
  services.fstrim.enable = true;

  # Audio
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };
  services.pulseaudio.enable = false;

  # Hyprland
  services.noctalia-shell.enable = true;

  programs.thunar.enable = true;
  services.blueman.enable = true;
  services.gvfs.enable = true;
  services.tumbler.enable = true;

  # Bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = false;

  # Noctalia shell battery
  services.upower.enable = true;

  # our attempt to let VIA see our keyboard
  services.udev.extraRules = ''
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="4e45", ATTRS{idProduct}=="3635", MODE="0660", GROUP="users", TAG+="uaccess", TAG+="udev-acl" 
  '';

  services.udev = {

    packages = with pkgs; [
      qmk
      qmk-udev-rules # the only relevant
      qmk_hid
      via
      vial
    ]; # packages

  };

  hardware.keyboard.qmk.enable = true;
}
