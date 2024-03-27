#!/usr/bin/env nix-shell
#! nix-shell -i bash -p stow git

source install-lib.sh

PROJECT_NAME="jwy-gh0stzk-dots"
REPO_NAME=$PROJECT_NAME
host_name="nixrice"
default_pass="password"
current_user_name=$(echo $USER)
user_name=$current_user_name




if [ -n "$(cat /etc/os-release | grep -i nixos)" ]; then
    echo "Verified this is NixOS."
    echo "-----"
else
    echo "This is not NixOS or the distribution information is not available."
    exit
fi


read -p "Do you want to do an express install? (use defaults)" -n 1 -r
if [[ $REPLY =~ ^[Nn]$ ]] ; then
  echo "Default options are in brackets []"
  echo "Just press enter to select the default"
  sleep 2

  echo "-----"

  read -p "Enter Your Username: [ $current_user_name ] " user_name_response
  if [ ! -z "$user_name_response" ]; then
    user_name=$user_name_response
  fi

  if [ $current_user_name != $user_name ]; then
    echo "This will create a hashedPassword for the new user in the options file."
    while true; do
      echo
      read -s -p "Enter New User Password: " new_pass
      echo
      read -s -p "Enter New User Password Again: " new_pass2
      if [ $new_pass == $new_pass2 ]; then
        echo "Passwords Match. Setting password."
        user_password=$(mkpasswd -m sha-512 $new_pass)
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
echo "Symlinking dot (.config) files using GNU Stow"
[ ! -d ~/.config ] && mkdir -p $XDG_CONFIG_HOME
[ ! -d ~/.local/bin ] && mkdir -p ~/.local/bin
[ ! -d ~/.local/share ] && mkdir -p ~/.local/share

#stow -R dots -t ~/ -v
#stow -R dots -t $XDG_CONFIG_HOME -v
#stow -R local -t  $LOCAL_DIR -v
#stow -R fonts -t $FONTS_DIR -v
fc-cache -rf

echo "-----"
echo "Installing custom Firefox startup page"
#sed -i "s/user_pref(\"browser.startup.homepage\", \"file:\/\/\/home\/z0mbi3\/.local\/share\/startup-page\/index.html\")/user_pref(\"browser.startup.homepage\", \"file:\/\/\/home\/$USER\/.local\/share\/startup-page\/index.html\")/" "$HOME"/.mozilla/firefox/*.default/user.js
sed -i "s/name: 'gh0stzk'/name: '$USER'/" "$HOME"/.local/share/startup-page/config.js

echo "-----"
echo "Generating The Hardware Configuration"
#sudo nixos-generate-config --show-hardware-config > hardware.nix

echo "-----"

echo "Now Going To Build $PROJECT_NAME, 🤞"
NIX_CONFIG="experimental-features = nix-command flakes" 

#sudo nixos-rebuild switch --flake .#$host_name

#  if [ $user_name != $current_user_name ]; then
#    echo "Ensuring $PROJECT_NAME repository is in your users HOME directory."
#    cd
#    cp -r $REPO_NAME /home/$user_name/
#    sudo chown -R $user_name:users /home/$user_name/$REPO_NAME
#  fi

echo "-----"

echo "$PROJECT_NAME Has Been Installed!"
