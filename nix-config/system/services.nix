{
  pkgs,
  config,
  lib,
  inputs,
  host,
  ...
}:

let
  inherit (import ../hosts/${host}/options.nix)
    keyboardVariant
    keyboardLayout
    ;
in
{

  # List services that you want to enable:
  services.openssh.enable = true;
  services.fstrim.enable = true;

  services.xserver = {
    enable = true;
    xkb = {
      variant = "${keyboardVariant}";
      layout = "${keyboardLayout}";
      options = "ctrl:nocaps";
    };
  };
  services.libinput.enable = true;

  # Audio
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };
  services.pulseaudio.enable = false;

  programs.thunar.enable = true;
  services.blueman.enable = true;
  services.gvfs.enable = true;
  services.tumbler.enable = true;

  programs.coolercontrol.enable = true;

  # Bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = false;

  # Noctalia shell battery
  services.upower.enable = true;

  # our attempt to let VIA see our keyboard
  services.udev.extraRules = ''
    # Let VIA see our keyboard
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="4e45", ATTRS{idProduct}=="3635", MODE="0660", GROUP="users", TAG+="uaccess", TAG+="udev-acl" 

    # Disable wakeup triggers for all PCIe devices
    ACTION=="add", SUBSYSTEM=="pci", DRIVER=="pcieport", ATTR{power/wakeup}="disabled"

    # Disable usb xHCI controller from waking up pc on ASRock AM5 motherboards
    ACTION=="add", SUBSYSTEM=="pci", KERNEL=="0000:08:00.0", ATTR{power/wakeup}="disabled"

    # Disable Logitech Universal Receiver wakeup 
    ACTION=="add", SUBSYSTEM=="usb", DRIVERS=="usb", ATTRS{idVendor}=="046d", ATTRS{idProduct}=="c52b|c548", ATTR{power/wakeup}="disabled"
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
