{ pkgs, config, inputs,  ... }:

{
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.joypixels.acceptLicense = true;


  # List System Programs
  environment.systemPackages = with pkgs; [
    # X related packages
    xdo xdotool
    xorg.xprop xorg.xkill xorg.xdpyinfo xorg.xsetroot xorg.xwininfo xorg.xrandr
    # misc helpful utilities
    eza wget curl git unzip unrar virt-viewer ripgrep
    fastfetch htop btop stow brightnessctl gparted
    # other
    polkit_gnome
    # secure boot
    sbctl
  ];

  programs = {
    #steam.gamescopeSession.enable = true;
    dconf.enable = true;
   # seahorse.enable=true;
   # hyprland = {
   #   enable = true;
   #   package = inputs.hyprland.packages.${pkgs.system}.hyprland;
   #   xwayland.enable = true;
   # };
    fuse.userAllowOther = true;
    mtr.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    virt-manager.enable = true;
  };

  virtualisation.libvirtd.enable = true;
}
