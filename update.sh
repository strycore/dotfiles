#!/usr/bin/env bash
function link_file {
    source="${PWD}/$1"
    target="${HOME}/.${1}"

    if [ -e "${target}" ]; then
        mv $target $target.bak
    fi

    ln -sf ${source} ${target}
}


git submodule sync
git submodule init
git submodule update
git submodule foreach git pull origin master
git submodule foreach git submodule init
git submodule foreach git submodule update

