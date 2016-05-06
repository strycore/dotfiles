#!/bin/bash

NODE_CURRENT="v6.1.0"
NVM_DIR="$HOME/.nvm"

if [ ! -d "$NVM_DIR" ]; then
    echo "nvm is not installed"
    curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.29.0/install.sh | bash
fi

source $NVM_DIR/nvm.sh

nvm install $NODE_CURRENT
nvm alias default $NODE_CURRENT
nvm use default

npm install bower -g
npm install browser-sync -g
npm install eslint -g
npm install generator-polymer -g
npm install grunt-cli -g
npm install gulp -g
npm install jshint -g
npm install polylint -g
npm install polyserve -g
npm install redis-commander -g
npm install yo -g
