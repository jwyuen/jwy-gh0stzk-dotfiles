#!/usr/bin/env nix-shell
#! nix-shell -i bash -p git

source install-lib.sh

echo "Removing the following theme files from temporary ignore list:"
for file in "${THEME_FILES[@]}"; do
  echo "$file"
  git update-index --no-assume-unchanged "$file"
done
