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

