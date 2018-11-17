#!/bin/bash

NODE_CURRENT="v11.2.0"
NVM_DIR="$HOME/.nvm"

if [ ! -d "$NVM_DIR" ]; then
    echo "Installing NVM"
    curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.1/install.sh | bash
fi

source $NVM_DIR/nvm.sh

nvm install $NODE_CURRENT
nvm alias default $NODE_CURRENT
nvm use default

npm install -g bower
npm install -g browser-sync
npm install -g eslint
npm install -g generator-polymer
npm install -g grunt-cli
npm install -g gulp
npm install -g jshint
npm install -g polylint
npm install -g polyserve
npm install -g polymer-cli
npm install -g redis-commander
npm install -g tern
npm install -g castnow
npm install -g @angular/cli
npm install -g tslint
