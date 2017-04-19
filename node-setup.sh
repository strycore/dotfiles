#!/bin/bash

NODE_CURRENT="v7.9.0"
NVM_DIR="$HOME/.nvm"

if [ ! -d "$NVM_DIR" ]; then
    echo "Installing NVM"
    curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.1/install.sh | bash
fi

source $NVM_DIR/nvm.sh

nvm install $NODE_CURRENT
nvm alias default $NODE_CURRENT
nvm use default

npm install pnpm -g
pnpm install bower -g
pnpm install browser-sync -g
pnpm install eslint -g
pnpm install generator-polymer -g
pnpm install grunt-cli -g
pnpm install gulp -g
pnpm install jshint -g
pnpm install polylint -g
pnpm install polyserve -g
pnpm install polymer-cli -g
pnpm install redis-commander -g
