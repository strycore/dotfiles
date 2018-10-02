#!/bin/bash 

set -e

# Fix terminal for Tilix
cd /etc/profile.d/
sudo ln -s vte-2.91.sh vte.sh

# Add KeepassXC PPA
sudo add-apt-repository --yes --no-update --enable-source ppa:phoerious/keepassxc

# Add GCDEmu PPA
sudo add-apt-repository --yes --no-update --enable-source ppa:cdemu/ppa

# Add Docker PPA
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository --yes --no-update --enable-source "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

# Add SC-Controller PPA
wget -nv https://download.opensuse.org/repositories/home:kozec/xUbuntu_18.04/Release.key -O - | sudo apt-key add -
sudo sh -c "echo 'deb http://download.opensuse.org/repositories/home:/kozec/xUbuntu_18.04/ /' > /etc/apt/sources.list.d/home:kozec.list"

# Add WineHQ PPA
wget -nc https://dl.winehq.org/wine-builds/Release.key -O - | sudo apt-key add -
sudo apt-add-repository --yes --no-update --enable-source https://dl.winehq.org/wine-builds/ubuntu/

# Install packages
sudo apt update
sudo apt full-upgrade
sudo apt install git keepassxc apt-file pavucontrol htop gimp chrome-gnome-shell vim-gnome synaptic \
    lm-sensors kdeconnect gcdemu python-dev python3-dev python3-pip silversearcher-ag lxd lxd-tools \
    nmap ncdu docker-ce ctags postgresql gnash libvulkan-dev libpng-dev libwayland-dev libxcb1-dev \
    meson ninja w3m devscripts git-buildpackage libgirepository1.0-dev debhelper mono-complete \
    neofetch jstest-gtk sc-controller mesa-utils mesa-vulkan-drivers linux-tools-common linux-tools-generic \
    winehq-staging gimp inkscape

sudo pip3 install flake8
sudo pip3 install pylint

sudo lxd init
newgrp lxd
