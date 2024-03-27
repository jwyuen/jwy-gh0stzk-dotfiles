{ pkgs, config, inputs, ... }:

{
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.joypixels.acceptLicense = true;


  # List System Programs
  environment.systemPackages = with pkgs; [
    # unix porn related
    brightnessctl dunst rofi bspwm polybar sxhkd jq ranger picom ueberzug
    tdrop eww
    # X related packages
    xdo xdotool jgmenu
    xorg.xprop xorg.xkill xorg.xdpyinfo xorg.xsetroot xorg.xwininfo xorg.xrandr
    # misc helpful utilities
    alacritty lsd wget curl git unzip unrar virt-viewer ripgrep networkmanagerapplet
    neofetch htop btop neovim wezterm stow
    # zsh related
    zsh zsh-autosuggestions zsh-history-substring-search zsh-syntax-highlighting
    # more system level stuff
    polkit_gnome libvirt physlock
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
