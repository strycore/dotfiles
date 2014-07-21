
# == Default programs
# I would normally use gvim if a display is available, but it seems to cause
# problem with dch.
export EDITOR='vim'
export BROWSER='firefox'

export EMAIL="strycore@gmail.com"
export FULLNAME="Mathieu Comandon"

# == Debian packaging variables
export DEBEMAIL=$EMAIL
export DEBFULLNAME=$FULLNAME

ZSH=$HOME/.oh-my-zsh
ZSH_THEME="sorin"

# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
plugins=(git python pip command-not-found ruby vundle zsh-syntax-highlighting fabric yum grunt)

source $ZSH/oh-my-zsh.sh

# Disable autocorrect
unsetopt correct_all

function powerline_precmd() {
    export PS1="$(~/.powerline-shell.py $? --shell zsh)"
}

function install_powerline_precmd() {
    for s in "${precmd_functions[@]}"; do
    if [ "$s" = "powerline_precmd" ]; then
        return
    fi
    done
    precmd_functions+=(powerline_precmd)
}

install_powerline_precmd

export PATH=$PATH:$HOME/bin
if [ -s $HOME/.rvm/bin ]; then
    export PATH=$PATH:$HOME/.rvm/bin
fi

if [ ! "$SSH_AGENT_PID" ]; then
    eval $(ssh-agent)
fi

if [ -e "$HOME/.profile" ]; then
    source $HOME/.profile
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

ubuntu_venvwrapper="/etc/bash_completion.d/virtualenvwrapper"
if [ -f $ubuntu_venvwrapper ]; then
    source $ubuntu_venvwrapper
else
    virtualenv=$(which virtualenvwrapper.sh)
    if [ -f "$virtualenv" ]; then
        source $virtualenv
    fi
fi

# RVM Configuration: Load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

alias image_reduce="find . -size +2M -name '*.jpg' -exec convert -resize 33% {} {} \;"
alias nuke='tr -dc " _" < /dev/urandom'
alias tmux='tmux -2'
alias lxls='sudo lxc-ls --fancy'

function lxcreate() {
    sudo lxc-create -t ${2:-strycore} -n $1
}

function lxstart() {
    sudo lxc-start -d -n $1
}

function lxedit() {
    container=$1
    if [ -z "$container" ]; then
        echo "Missing container name"
    else
        sudo $EDITOR /var/lib/lxc/${container}/config
    fi
}

function lxreboot() {
    container=$1
    if [ -z "$container" ]; then
        echo "Missing container name"
    else
        sudo lxc-stop -n ${container}
        sudo lxc-start -n ${container} -d
    fi
}

function deploy() {
    cwd=$(pwd)
    if [ ! -e fabfile.py ]; then
        cd ..
        if [ ! -e fabfile.py ]; then
            echo "No fabfile found"
            return -2
        fi
    fi
    fab preview deploy --password="$(cat ~/.django.password)"
    cd $cwd
    unset $cwd
}

function search() {
    for i in "$@"; do
        ( find -iname "*$i*" | grep -i "$i" --color=auto ) 2> /dev/null;
    done
}

function say() {
    if [[ "${1}" =~ -[a-z]{2} ]]; then
        local lang=${1#-};
        local text="${*#$1}";
    else
        local lang=${LANG%_};
        local text="${1}";
    fi;
    mplayer "http://translate.google.com/translate_tts?ie=UTF-8&tl=${lang}&q=${text}"
}

function ack() {
    killall python
    killall firefox
    killall terminator
    killall gvim
    killall hexchat
    echo "Hahaha, next time try 'ag'"
}

function fuck() {
  if killall -9 "$2"; then
    echo ; echo " (╯°□°）╯︵$(echo "$2"|toilet -f term -F rotate)"; echo
  fi
}

function goodbyeworld() {
    for pid in $(ps -u $USER -o pid); do
        kill -9 $pid
    done
}

function dj {
    PROJECT=$1 tmux -f $HOME/.tmux.django.conf attach
}

# Author: Édouard Lopez
# License: MIT
# URL: https://github.com/edouard-lopez/dotfiles
# Edit given file with adequate rights (sudo/user)
# @param    $@|$1  file(s) name
function e() {
    filename="$1"
    perm_check="$filename"

    if [[ ! -z "$filename" && ! -e "$filename" ]]; then
        perm_check=$(dirname "$filename")
    fi

    if [[ -w "$perm_check" ]]; then
        $EDITOR "$filename"
    else
        touch "$filename"
        sudo -e "$filename"
    fi
}

# Author: Julien Phalip
# License: BSD
# Change the current directory to the path of the given Python package.
function pcd {
    cd `python -c "import pkgutil; print(pkgutil.get_loader('$1').filename)"`
}

function _top_level_packages {
    python -c "import pkgutil; print('\n'.join([name for loader, name, ispkg in sorted(pkgutil.iter_modules()) if ispkg]))"
}


if [ -n "$BASH" ] ; then
    _pcd_complete () {
        local cur="${COMP_WORDS[COMP_CWORD]}"
        COMPREPLY=( $(compgen -W "`_top_level_packages`" -- ${cur}) )
    }
    complete -o default -o nospace -F _goto_complete goto
elif [ -n "$ZSH_VERSION" ] ; then
    _pcd_complete () {
        reply=( $(_top_level_packages) )
    }
    compctl -K _pcd_complete pcd
    _dj_complete () {
        reply=( $(workon) )
    }
    compctl -K _dj_complete dj
fi

# Force a reload of completion system if nothing matched; this fixes installing
# a program and then trying to tab-complete its name
_force_rehash() {
    (( CURRENT == 1 )) && rehash
    return 1    # Because we didn't really complete anything
}
# Always use menu completion, and make the colors pretty!
zstyle ':completion:*' menu select yes
zstyle ':completion:*:default' list-colors ''

# Completers to use: rehash, general completion, then various magic stuff and
# spell-checking.  Only allow two errors when correcting
zstyle ':completion:*' completer _force_rehash _complete _ignored _match _correct _approximate _prefix
zstyle ':completion:*' max-errors 2

# When looking for matches, first try exact matches, then case-insensiive, then
# partial word completion
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'r:|[._-]=** r:|=**'

# Turn on caching, which helps with e.g. apt
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

# Show titles for completion types and group by type
zstyle ':completion:*:descriptions' format "$fg_bold[black]» %d$reset_color"
zstyle ':completion:*' group-name ''

# Ignore some common useless files
zstyle ':completion:*' ignored-patterns '*?.pyc' '__pycache__'
zstyle ':completion:*:*:rm:*:*' ignored-patterns

bindkey '^i' complete-word              # tab to do menu
bindkey "\e[Z" reverse-menu-complete    # shift-tab to reverse menu

unset -f work_in_progress
