{
  pkgs,
  config,
  inputs,
  ...
}:

{
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.joypixels.acceptLicense = true;

  # List System Programs
  environment.systemPackages = with pkgs; [
    # X related packages
    xdo
    xdotool
    xorg.xprop
    xorg.xkill
    xorg.xdpyinfo
    xorg.xsetroot
    xorg.xwininfo
    xorg.xrandr

    # Hyprland
    #noctalia-shell
    inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default

    # misc helpful utilities
    eza
    wget
    curl
    gitFull
    unzip
    unrar
    virt-viewer
    ripgrep
    fastfetch
    stow
    brightnessctl
    gparted
    # other
    polkit_gnome
    # secure boot
    sbctl

    # monitoring utils
    btop
    s-tui # stress tester
    iftop # network monitoring
    iotop # disk io monitoring
    nvtopPackages.full # gpu monitoring
    wireshark # packet monitoring

    # uwsm deps
    util-linux
    newt # provides whiptail
    libnotify # provides notify-send
    inotify-tools # provides inotifywait
  ];

  programs = {
    neovim.enable = true;
    #steam.gamescopeSession.enable = true;
    dconf.enable = true;
    seahorse.enable = true;
    hyprland = {
      enable = true;
      #package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      withUWSM = true;
      xwayland.enable = true;
    };
    # Universal Wayland Session Manager
    uwsm.enable = true;
    fuse.userAllowOther = true;
    # network diagnostic tool
    mtr.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    virt-manager.enable = true;
  };

  virtualisation.libvirtd.enable = true;
}
