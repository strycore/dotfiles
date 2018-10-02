#!/bin/bash 

set -e

# Fix terminal for Tilix
sudo ln -s /etc/profile.d/vte-2.91.sh /etc/profile.d/vte.sh

# Add KeepassXC PPA
sudo add-apt-repository --yes --no-update --enable-source ppa:phoerious/keepassxc

# Add GCDEmu PPA
sudo add-apt-repository --yes --no-update --enable-source ppa:cdemu/ppa

# Add Docker repository
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository --yes --no-update --enable-source "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

# Add SC-Controller repository
wget -nv https://download.opensuse.org/repositories/home:kozec/xUbuntu_18.04/Release.key -O - | sudo apt-key add -
sudo sh -c "echo 'deb http://download.opensuse.org/repositories/home:/kozec/xUbuntu_18.04/ /' > /etc/apt/sources.list.d/home:kozec.list"

# Add WineHQ repository
wget -nc https://dl.winehq.org/wine-builds/Release.key -O - | sudo apt-key add -
sudo apt-add-repository --yes --no-update --enable-source "https://dl.winehq.org/wine-builds/ubuntu/"

# Add VirtualBox repository
wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add -
sudo apt-add-repository --yes --no-update --enable-source "deb https://download.virtualbox.org/virtualbox/debian bionic contrib"

# Add Lutris repository
ver=$(lsb_release -sr); if [ $ver != "18.04" -a $ver != "16.04" ]; then ver=18.04; fi 
echo "deb http://download.opensuse.org/repositories/home:/strycore/xUbuntu_$ver/ ./" | sudo tee /etc/apt/sources.list.d/lutris.list
wget -q http://download.opensuse.org/repositories/home:/strycore/xUbuntu_$ver/Release.key -O- | sudo apt-key add -

# Install packages
sudo apt update
sudo apt full-upgrade
sudo apt install git keepassxc apt-file pavucontrol htop gimp chrome-gnome-shell vim-gnome synaptic \
    lm-sensors kdeconnect gcdemu python-dev python3-dev python3-pip silversearcher-ag lxd lxd-tools \
    nmap ncdu docker-ce ctags postgresql gnash libvulkan-dev libpng-dev libwayland-dev libxcb1-dev \
    meson ninja w3m devscripts git-buildpackage libgirepository1.0-dev debhelper mono-complete \
    neofetch jstest-gtk sc-controller mesa-utils mesa-vulkan-drivers linux-tools-common linux-tools-generic \
    winehq-staging gimp inkscape lutris virtualbox-5.2 tilix

# Install Chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb
rm google-chrome-stable_current_amd64.deb

# Install Discord
https://dl.discordapp.net/apps/linux/0.0.5/discord-0.0.5.deb
sudo dpkg -i discord-0.0.5.deb
rm discord-0.0.5.deb

sudo pip3 install flake8
sudo pip3 install pylint

sudo lxd init
newgrp lxd
