#!/bin/bash

mkdir -p ~/.fonts

git clone https://github.com/powerline/fonts.git powerline-fonts
cd powerline-fonts
./install.sh
cd ..
rm -rf powerline-fonts

git clone https://github.com/gabrielelana/awesome-terminal-fonts.git
cd awesome-terminal-fonts
git checkout patching-strategy
cd patched
cp *.ttf ~/.fonts
cd ../..
rm -rf awesome-terminal-fonts
