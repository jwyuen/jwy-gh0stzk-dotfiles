#!/usr/bin/env nix-shell
#! nix-shell -i bash -p stow

source install-lib.sh

# -D option unlinks the symlinks 
#stow -D home-files -t ~/ -v
stow -D dots -t ~/ -v
#stow -D dots -t $XDG_CONFIG_HOME -v
#stow -D local -t $LOCAL_DIR -v
#stow -D fonts -t $FONTS_DIR -v


