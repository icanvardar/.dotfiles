#!/bin/bash

# get username
username=$1

# unzip font zip
sudo unzip /home/${username}/.dotfiles/i3/.config/i3/fonts/MartianMono.zip -d /home/${username}/.dotfiles/i3/.config/i3/fonts/default

# create a fonts directory
sudo mkdir /usr/share/fonts

# copy the default font for i3 content to the fonts directory
sudo cp /home/${username}/.dotfiles/i3/.config/i3/fonts/default/*.tff /usr/share/fonts

# cache the default font for i3
sudo fc-cache -f -v
