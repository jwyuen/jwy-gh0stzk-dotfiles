#!/usr/bin/env nix-shell
#! nix-shell -i bash -p stow git

source install-lib.sh

PROJECT_NAME="jwy-gh0stzk-dots"
REPO_NAME=$PROJECT_NAME
host_name="nixrice"
default_pass="password"

#mkdir -p $FONTS_DIR
#stow -R home-files -t ~/ -v
stow -R dots -t $XDG_CONFIG_HOME -v
#stow -R fonts -t $FONTS_DIR -v

# TODO: test stowing the other config files from RiceInstaller


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

  current_user_name=$(echo $USER)
  read -p "Enter Your Username: [ $current_user_name ] " user_name
  if [ -z "$user_name" ]; then
    user_name=$(echo $USER)
  else
    if [ $current_user_name != $user_name ]; then
      echo "This will create a hashedPassword for the new user in the options file."
      while true; do
        read -s -p "Enter New User Password: " new_pass
        read -s -p "Enter New User Password Again: " new_pass2
        if [ $new_pass == $new_pass2 ]; then
    echo "Passwords Match. Setting password."
    user_password=$(mkpasswd -m sha-512 $new_pass)
    escaped_user_password=$(echo "$user_password" | sed 's/\//\\\//g')
    sed -i "/^\s*hashedPassword[[:space:]]*=[[:space:]]*\"/s#\"\(.*\)\"#\"$escaped_user_password\"#" ./system.nix
    break
        fi
      done
    fi
  fi
  sed -i "/^\s*username[[:space:]]*=[[:space:]]*\"/s/\"\(.*\)\"/\"$user_name\"/" ./options.nix

  if [ $user_name != $current_user_name ]; then
    echo "Ensuring $PROJECT_NAME repository is in your users HOME directory."
    cd
    cp -r $REPO_NAME /home/$user_name/
    sudo chown -R $user_name:users /home/$user_name/$REPO_NAME
  fi

else
  # express install stuff here

fi




echo "Generating The Hardware Configuration"
#sudo nixos-generate-config --show-hardware-config > hardware.nix

echo "-----"

echo "Now Going To Build $PROJECT_NAME, 🤞"
NIX_CONFIG="experimental-features = nix-command flakes" 

#sudo nixos-rebuild switch --flake .#$host_name


echo "-----"

echo "$PROJECT_NAME Has Been Installed!"
