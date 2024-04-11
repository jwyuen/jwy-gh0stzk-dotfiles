{ pkgs, inputs, config, username, ... }:

let 
  inherit (import ../../options.nix) 
    browser wallpaperDir wallpaperGit flakeDir;
in {
  # Install Packages For The User
  home.packages = with pkgs; [
    # unix porn related
    dunst bspwm polybar sxhkd jq ranger picom ueberzug rofi tdrop eww jgmenu
    dmenu
    # audio related
    playerctl mpd ncmpcpp mpc-cli pamixer
    # dev related
    alacritty wezterm geany rustup libvirt maim papirus-icon-theme joypixels zig gcc
    lazygit xclip zoxide fzf fd
    # zsh related
    zsh zsh-autosuggestions zsh-history-substring-search zsh-syntax-highlighting
    zsh-autocomplete
    # image related
    gdk-pixbuf webp-pixbuf-loader imagemagick libwebp feh
    #nixpkgs-unstable.legacyPackages.${pkgs.system}.webp-pixbuf-loader
    # other
    betterlockscreen networkmanager networkmanager_dmenu nh tldr

    # fonts
    cherry clarity-city cozette
    (nerdfonts.override { fonts = [
      "JetBrainsMono" "Terminus" "Inconsolata"
    ]; })

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

  programs.gh.enable = true;
}
