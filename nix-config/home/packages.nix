{
  pkgs,
  inputs,
  config,
  username,
  host,
  ...
}:

let
  inherit (import ../hosts/${host}/options.nix)
    browser
    wallpaperDir
    wallpaperGit
    flakeDir
    ;
in
{
  # Install Packages For The User
  home.packages = with pkgs; [
    # unix porn related
    dunst
    bspwm
    dmenu
    sxhkd
    jq
    ranger
    picom
    ueberzug
    rofi
    tdrop
    eww
    jgmenu
    polybarFull
    polybar-pulseaudio-control
    # audio related
    libmpdclient
    playerctl
    mpd
    ncmpcpp
    mpc-cli
    pamixer
    # dev related
    alacritty
    geany
    libvirt
    maim
    papirus-icon-theme
    joypixels
    zig
    gcc
    lazygit
    xclip
    zoxide
    fzf
    fd
    sesh
    docker
    mysql-workbench
    delta
    # zsh related
    zsh
    zsh-autosuggestions
    zsh-history-substring-search
    zsh-syntax-highlighting
    zsh-autocomplete
    # image related
    gdk-pixbuf
    webp-pixbuf-loader
    imagemagick
    libwebp
    feh
    #nixpkgs-unstable.legacyPackages.${pkgs.system}.webp-pixbuf-loader
    # other
    betterlockscreen
    nh
    tldr
    tor-browser
    networkmanager_dmenu
    networkmanagerapplet
    thunderbird
    inetutils
    remmina
    keepassxc

    # fonts
    cherry
    clarity-city
    cozette
    maple-mono.NF
    terminus_font
    nerd-fonts.dejavu-sans-mono
    nerd-fonts.fira-code
    nerd-fonts.hack
    nerd-fonts.inconsolata
    nerd-fonts.jetbrains-mono
    nerd-fonts.monofur
    nerd-fonts.mononoki
    nerd-fonts.ubuntu-sans

    # Meh don't use
    #nerd-fonts.noto
    #nerd-fonts.recursive-mono

    # (nerdfonts.override {
    #   fonts = [
    #     "JetBrainsMono"
    #     "Terminus"
    #     "Inconsolata"
    #   ];
    # })

    # Import Scripts
    #    (import ./../scripts/emopicker9000.nix { inherit pkgs; })
    #    (import ./../scripts/task-waybar.nix { inherit pkgs; })
    #    (import ./../scripts/squirtle.nix { inherit pkgs; })
    #    (import ./../scripts/wallsetter.nix { inherit pkgs; inherit wallpaperDir;
    #      inherit username; inherit wallpaperGit; })
    #    (import ./../scripts/themechange.nix { inherit pkgs; inherit flakeDir; })
    #    (import ./../scripts/theme-selector.nix { inherit pkgs; })
    #    (import ./../scripts/nvidia-offload.nix { inherit pkgs; })
    #    (import ./../scripts/web-search.nix { inherit pkgs; })
    #    (import ./../scripts/rofi-launcher.nix { inherit pkgs; })
    #    (import ./../scripts/screenshootin.nix { inherit pkgs; })
    #    (import ./../scripts/list-hypr-bindings.nix { inherit pkgs; })
  ];

  programs = {
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    gh.enable = true;
  };
}
