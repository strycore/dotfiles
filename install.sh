#!/usr/bin/env bash
function link_file {
    source="${PWD}/$1"
    target="${HOME}/.${1}"

    if [ -e "${target}" ]
    then
        if [ "_$(readlink ${target})" == "_${source}" ]
        then
            echo "[SKIP] Existing target ${target}, skipping file $1"
            return
        else
            backup=$target.backup$(date +%s)
            echo "[BCKP] Saving backup of exising file ${target} as ${backup}"
            mv $target $backup
        fi
    fi
    echo "[ OK ] Creating link to ${source}"
    ln -sf ${source} ${target}
}

link_file vim
link_file vimrc
link_file profile
link_file bashrc
link_file zshrc
link_file screenrc
link_file pylintrc
link_file gitconfig
link_file hgrc
link_file ackrc

if [ ! -e "$HOME/.oh-my-zsh" ]
then
    echo "[INST] Installing oh-my-zsh"
    curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh
else
    echo "[SKIP] oh-my-zsh is already installed"
fi

if [ ! -e $(which flake8) ]
then
   sudo pip install flake8
else
    echo "[SKIP] Flake8 is already installed"
fi

if [ ! -e $(which pysmell) ]
then
   sudo pip install pysmell
else
    echo "[SKIP] Pysmell is already installed"
fi

if [ -z $(which jshint) ]
then
    echo "[INST] Installing jshint"
    sudo npm install jshint -g
fi

if [ -z $(which lessc) ]
then
    echo "[INST] Installing lesscss compiler"
    sudo npm install less -g
fi

if [ -z $(which coffee) ]
then
    echo "[INST] Installing coffeescript compiler"
    sudo npm install coffee-script -g
fi
