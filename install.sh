#!/usr/bin/env nix-shell
#! nix-shell -i bash -p stow git

source install-lib.sh

PROJECT_NAME="jwy-gh0stzk-dotfiles"
REPO_NAME=$PROJECT_NAME
current_user_name=$USER
user_name=$current_user_name


if [ -n "$(cat /etc/os-release | grep -i nixos)" ]; then
    echo "Verified this is NixOS."
    echo "-----"
else
    echo "This is not NixOS or the distribution information is not available."
    exit
fi

echo "Default options are in brackets []"
echo "Just press enter to select the default"

echo "-----"

read -rp "Enter Your Hostname: [ nix-vm ] " host_name
if [ -z "$host_name" ]; then
  host_name="nix-vm"
fi

read -p "Do you want to do an express install? [use defaults] " -n 1 -r
if [[ $REPLY =~ ^[Nn]$ ]] ; then
  
  read -rp "Enter Your Username: [ $current_user_name ] " user_name_response
  if [ ! -z "$user_name_response" ]; then
    user_name=$user_name_response
  fi

  if [ "$current_user_name" != "$user_name" ]; then
    echo "This will create a hashedPassword for the new user in the options file."
    while true; do
      echo
      read -s -p -r "Enter New User Password: " new_pass
      echo
      read -s -p -r "Enter New User Password Again: " new_pass2
      if [ "$new_pass" == "$new_pass2" ]; then
        echo "Passwords Match. Setting password."
        user_password=$(mkpasswd -m sha-512 "$new_pass")
        escaped_user_password=$(echo "$user_password" | sed 's/\//\\\//g')
        sed -i "/^\s*hashedPassword[[:space:]]*=[[:space:]]*\"/s#\"\(.*\)\"#\"$escaped_user_password\"#" ./system.nix
        break
      fi
    done

    sed -i "/^\s*username[[:space:]]*=[[:space:]]*\"/s/\"\(.*\)\"/\"$user_name\"/" ./options.nix
  fi

  

else
  # express install stuff here
  echo "-----"
  echo "Doing express install"

fi


echo "-----"
echo "Symlinking dot (.config and .local) files using GNU Stow"
[ ! -d ~/.config ] && mkdir -p $XDG_CONFIG_HOME
[ ! -d ~/.local/bin ] && mkdir -p ~/.local/bin
[ ! -d ~/.local/share ] && mkdir -p ~/.local/share

cd $PROJECT_DIR/dots && stow -R config -t ~/.config/ -v
cd $PROJECT_DIR/dots && stow -R local -t ~/.local/ -v
cd $PROJECT_DIR || exit

fc-cache -rf

#echo "-----"
#echo "Installing custom Firefox startup page"
#sed -i "s/user_pref(\"browser.startup.homepage\", \"file:\/\/\/home\/z0mbi3\/.local\/share\/startup-page\/index.html\")/user_pref(\"browser.startup.homepage\", \"file:\/\/\/home\/$USER\/.local\/share\/startup-page\/index.html\")/" "$HOME"/.mozilla/firefox/*.default/user.js
#sed -i "s/name: 'gh0stzk'/name: '$USER'/" "$HOME"/.local/share/startup-page/config.js

echo "-----"
echo "Generating The Hardware Configuration"
sudo nixos-generate-config --show-hardware-config > ./nix-config/hosts/$host_name/hardware.nix

echo "-----"

echo "Now Going To Build $PROJECT_NAME, 🤞"
#NIX_CONFIG="experimental-features = nix-command flakes" 

if [ "$user_name" != "$current_user_name" ]; then
  echo "Ensuring $PROJECT_NAME repository is in your users HOME directory."
  cd ... || exit
  cp -r $REPO_NAME /home/"$user_name"/
  sudo chown -R "$user_name":users /home/"$user_name"/$REPO_NAME
fi
sed -i "/^\s*host[[:space:]]*=[[:space:]]*\"/s/\"\(.*\)\"/\"$host_name\"/" ./flake.nix

echo "using the following host name: $host_name"
if sudo nixos-rebuild switch --flake .#"$host_name" --show-trace; then
  echo "-----"
  echo "$PROJECT_NAME Has Been Installed!"
fi

echo "-----"
echo "Cleaning up..."
git restore ./flake.nix
echo "Done!"
