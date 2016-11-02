#!/bin/bash

git clone https://github.com/powerline/fonts.git powerline-fonts
cd powerline-fonts
./install.sh
cd ..
rm -rf powerline-fonts
