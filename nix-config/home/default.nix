{ pkgs, config, ... }:

{
  imports = [
    # Enable &/ Configure Programs
    ./alacritty.nix
#    ./bash.nix
    ./betterlockscreen.nix
    ./firefox.nix
#    ./gtk-qt.nix
#    ./hyprland.nix
#    ./kdenlive.nix
#    ./kitty.nix
    ./mpd.nix
    ./neovim.nix
    ./packages.nix
#    ./rofi.nix
#    ./waybar.nix
#    ./wlogout.nix
    ./starship.nix
#    ./swappy.nix
#    ./swaylock.nix
#    ./swaync.nix
    ./tmux.nix
#    ./wezterm.nix
#    ./zeroad.nix
    ./zsh.nix

    # Place home and dot files like Pictures
    ./files.nix
  ];
}
