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

  # Screensharing
  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal
    ];
    configPackages = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal
    ];
  };

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

  #Upower is a dbus service that provides power management support to apps
  services.upower.enable = true;

  # our attempt to let VIA see our keyboard
  services.udev.extraRules = ''
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="4e45", ATTRS{idProduct}=="3635", MODE="0660", GROUP="users", TAG+="uaccess", TAG+="udev-acl" 
  '';

  # disable wakeup triggers for all PCIe devices
  # services.udev.extraRules = ''
  #   ACTION=="add" SUBSYSTEM=="pci" ATTR{vendor}=="0x1022" ATTR{device}=="0x1483" ATTR{power/wakeup}="disabled"
  # '';
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

  # Security
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.sddm.enableGnomeKeyring = true;
  #security.pam.services.login.enableGnomeKeyring = true;
  security.rtkit.enable = true;
  security.pam.services.i3lock.enable = true;
  security.pam.services.i3lock-color.enable = true;
  security.pam.services.betterlockscreen = {

    text = ''
      auth include login
    '';
  };
}
