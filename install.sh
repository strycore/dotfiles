#!/usr/bin/env bash

set -e

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
            echo "[BACKUP] Saving backup of exising file ${target} as ${backup}"
            mv $target $backup
        fi
    fi
    echo "[ OK ] Creating link to ${source}"
    ln -sf ${source} ${target}
}

link_file vim
link_file vimrc
link_file bashrc
link_file zshrc
link_file screenrc
link_file pylintrc
link_file gitconfig
link_file gitignore_global
link_file hgrc
link_file ackrc
link_file tmux.conf
link_file tmux.django.conf
link_file dput.cf

if [ "$(basename "$SHELL")" != "zsh" -a -f "$(which zsh)" ]; then
    echo "Switching default shell to zsh, please enter your password:"
    chsh -s $(which zsh)
fi

if [ ! -d "$HOME/.oh-my-zsh" ]
then
    echo "[INSTALL] Installing oh-my-zsh"
    curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | bash
    mkdir -p ~/.oh-my-zsh/custom/plugins
else
    echo "[SKIP] oh-my-zsh is already installed"
fi

if [ -d $HOME/.oh-my-zsh/custom ]; then
	if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/grunt" ]; then
	    echo "[INSTALL] oh-my-zsh Grunt plugin"
	    mkdir -p ~/.oh-my-zsh/custom/plugins
	    git clone https://github.com/yonchu/grunt-zsh-completion.git ~/.oh-my-zsh/custom/plugins/grunt
	fi

	if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting" ]; then
	    mkdir -p ~/.oh-my-zsh/custom/plugins
	    git clone git://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/
	fi
fi

mkdir -p ~/.config/terminator
if [ ! -e ~/.config/terminator/config ]; then
    ln -s $(pwd)/terminator/config ~/.config/terminator/config
fi

if [ ! -e ~/.powerline-shell.py ]; then
    rm -rf powerline-shell
    git clone https://github.com/milkbikis/powerline-shell
    cd powerline-shell
    ./install.py
    ln -s $(pwd)/powerline-shell.py ~/.powerline-shell.py
    cd ..
fi
