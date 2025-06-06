{
  pkgs,
  config,
  lib,
  ...
}:

{
  # List services that you want to enable:
  services.openssh.enable = true;
  services.fstrim.enable = true;
  # xdg.portal = {
  #   enable = true;
  #   extraPortals = [ pkgs.xdg-desktop-portal-gtk
  #     pkgs.xdg-desktop-portal
  #   ];
  #   configPackages = [ pkgs.xdg-desktop-portal-gtk
  #     pkgs.xdg-desktop-portal-hyprland
  #     pkgs.xdg-desktop-portal
  #   ];
  # };
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };
  security.rtkit.enable = true;
  programs.thunar.enable = true;
  services.blueman.enable = true;
  services.gvfs.enable = true;
  services.pulseaudio.enable = false;
  services.tumbler.enable = true;
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = false; # powers up the default Bluetooth controller on boot

  services.gnome.gnome-keyring.enable = true;
  security.pam.services.sddm.enableGnomeKeyring = true;
  #security.pam.services.login.enableGnomeKeyring = true;

  security.pam.services.i3lock.enable = true;
  security.pam.services.i3lock-color.enable = true;
  security.pam.services.betterlockscreen = {

    text = ''
      auth include login
    '';
  };
}
