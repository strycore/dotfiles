#!/bin/bash

NODE_CURRENT="v11.2.0"
NVM_DIR="$HOME/.nvm"

if [ ! -d "$NVM_DIR" ]; then
    echo "Installing NVM"
    mkdir $NVM_DIR
    curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash
fi
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
# source $NVM_DIR/nvm.sh

nvm install $NODE_CURRENT
nvm alias default $NODE_CURRENT
nvm use default

npm install -g eslint
npm install -g tern
npm install -g tslint
npm install -g @vue/cli
