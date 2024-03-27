{ pkgs, config, inputs, ... }:

{
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List System Programs
  environment.systemPackages = with pkgs; [
    rustup bspwm polybar sxhkd 
    alacritty brightnessctl dunst rofi lsd 
    jq polkit_gnome git playerctl mpd xclip 
    ncmpcpp geany ranger mpc-cli picom xdo xdotool jgmenu 
    feh ueberzug maim pamixer libwebp xdg-user-dirs 
    webp-pixbuf-loader physlock papirus-icon-theme imagemagick
  #  ttf-jetbrains-mono ttf-jetbrains-mono-nerd ttf-terminus-nerd ttf-inconsolata ttf-joypixels 
    xorg.xprop xorg.xkill xorg.xdpyinfo xorg.xsetroot xorg.xwininfo xorg.xrandr
    wget curl git libvirt unzip unrar virt-viewer ripgrep networkmanagerapplet
    neofetch htop btop vim git neovim wezterm
    zsh zsh-autosuggestions zsh-history-substring-search zsh-syntax-highlighting
  ];

  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; })
  ];

 # environment.systemPackages = with pkgs; [
 #   wget curl git cmatrix lolcat neofetch htop btop libvirt
 #   polkit_gnome lm_sensors unzip unrar libnotify eza
 #   v4l-utils ydotool wl-clipboard socat cowsay lsd lshw
 #   pkg-config meson hugo gnumake ninja go nodejs symbola
 #   noto-fonts-color-emoji material-icons brightnessctl
 #   toybox virt-viewer swappy ripgrep appimage-run 
 #   networkmanagerapplet yad playerctl nh
 # ];

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
