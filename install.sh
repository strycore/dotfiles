#!/usr/bin/env bash
function link_file {
    source="${PWD}/$1"
    target="${HOME}/.${1}"

    if [ -e "${target}" ]
    then
        if [ $(readlink ${target}) == ${source} ]
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
link_file zshrc
link_file screenrc
link_file pylintrc
link_file gitconfig

