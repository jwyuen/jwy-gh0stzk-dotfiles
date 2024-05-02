#!/usr/bin/env nix-shell
#! nix-shell -i bash -p git

source install-lib.sh

echo "Adding the following theme files to temporary ignore list for development purposes:"
for file in "${THEME_FILES[@]}"; do
  echo "$file"
  git update-index --assume-unchanged "$file"
done
