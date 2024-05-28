#!/usr/bin/env nix-shell
#! nix-shell -i bash -p stow

source install-lib.sh

# -D option unlinks the symlinks 
cd $PROJECT_DIR/dots && stow -D config -t ~/.config -v
cd $PROJECT_DIR/dots && stow -D local -t ~/.local -v



