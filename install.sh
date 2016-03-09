#!/usr/bin/env bash

set -e

function link_file {
    source="${PWD}/$1"
    if [[ "${2}" ]]; then
        target="${2}/${1}"
    else
        target="${HOME}/.${1}"
    fi

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
link_file eslintrc
link_file gitconfig
link_file gitignore_global
link_file hgrc
link_file ackrc
link_file tmux.conf
link_file tmux.django.conf
link_file dput.cf
link_file mancolor
mkdir -p $HOME/.config
link_file flake8 $HOME/.config

if [ "$(basename "$SHELL")" != "zsh" -a -f "$(which zsh)" ]; then
    echo "Switching default shell to zsh, please enter your password:"
    chsh -s $(which zsh)
fi

if [ ! -d "$HOME/.oh-my-zsh" ]
then
    echo "[INSTALL] Installing oh-my-zsh"
    if [ "$(which curl)" ]; then
        curl -L http://install.ohmyz.sh | bash
    elif [ "$(which wget)" ]; then
        wget --no-check-certificate http://install.ohmyz.sh -O - | bash
    fi
    # Check that OhMyZsh as been installed and create custom plugin dir
    if [ -f "$HOME/.oh-my-zsh/oh-my-zsh.sh" ]; then
        mkdir -p ~/.oh-my-zsh/custom/plugins
    fi
else
    echo "[SKIP] oh-my-zsh is already installed"
fi

if [ -d $HOME/.oh-my-zsh/custom ]; then
    if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/grunt" ]; then
        echo "[INSTALL] zsh Grunt plugin"
        mkdir -p ~/.oh-my-zsh/custom/plugins
        git clone https://github.com/yonchu/grunt-zsh-completion.git ~/.oh-my-zsh/custom/plugins/grunt
    fi

    if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting" ]; then
        echo "[INSTALL] zsh syntax highlighting"
        mkdir -p ~/.oh-my-zsh/custom/plugins
        git clone git://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/
    fi

    if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/git-flow-completion" ]; then
        echo "[INSTALL] zsh git flow completion"
        git clone https://github.com/bobthecow/git-flow-completion ~/.oh-my-zsh/custom/plugins/git-flow-completion
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

if [ ! -e "$(which fzf)" ]; then
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install --no-update-rc
fi

# Check that the running system has enough inotify watches

watches=$(cat /proc/sys/fs/inotify/max_user_watches)
if [ $watches -lt 524288 ]; then
    echo "*********************************************************************"
    echo "*********************************************************************"
    echo "*********************************************************************"
    echo "*********************************************************************"
    echo "*****                                                           *****"
    echo "*****                                                           *****"
    echo "*****     YOUR NUMBER OF INOTIFY WATCHES IS DANGEROUSLY LOW.    *****"
    echo "*****     SEVERAL TOOLS SUCH AS TAIL, LIVERELOAD AND DROPBOX    *****"
    echo "*****     WON'T WORK PROPERLY.                                  *****"
    echo "*****                                                           *****"
    echo "*****     PLEASE FIX THIS ASAP!! RUN AS ROOT:                   *****"
    echo "*****                                                           *****"
    echo "***** echo 524288 > /proc/sys/fs/inotify/max_user_watches       *****"
    echo "*****echo fs.inotify.max_user_watches=524288 >> /etc/sysctl.conf*****"
    echo "*****                                                           *****"
    echo "*****                                                           *****"
    echo "*********************************************************************"
    echo "*********************************************************************"
    echo "*********************************************************************"
    echo "*********************************************************************"
fi
