{ pkgs, config, username, ... }:

let 
  inherit (import ../../options.nix) 
    browser wallpaperDir wallpaperGit flakeDir;
in {
  # Install Packages For The User
  home.packages = with pkgs; [
    pkgs."${browser}"
    # audio related
    playerctl mpd ncmpcpp mpc-cli pamixer
    # dev related
    geany rustup
    webp-pixbuf-loader imagemagick libwebp feh
    xclip maim papirus-icon-theme joypixels
    #discord

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
