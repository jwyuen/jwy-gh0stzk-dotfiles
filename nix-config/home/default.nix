{ host, ... }:
let
  vars = import ../hosts/${host}/options.nix;
  inherit (vars)
    alacrittyEnable
    barChoice
    ghosttyEnable
    tmuxEnable
    waybarChoice
    weztermEnable
    vscodeEnable
    helixEnable
    doomEmacsEnable
    antigravityEnable
    ;
  # Select bar module based on barChoice
  barModule = if barChoice == "noctalia" then ./noctalia.nix else waybarChoice;
in
{

  imports = [
    # Enable &/ Configure Programs
    ./alacritty.nix
    ./betterlockscreen.nix
    ./firefox.nix
    ./hyprland
    ./mpd.nix
    ./neovim.nix
    ./packages.nix
    ./starship.nix
    ./stylix.nix
    ./tmux.nix
    ./zen-browser.nix
    ./zsh.nix

    # Place home and dot files like Pictures
    ./files.nix
  ];
}
