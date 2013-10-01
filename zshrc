
# == Default programs
export EDITOR='vim'      # Default text editor
export BROWSER='firefox' # Default web browser

# == Debian packaging variables
export DEBEMAIL="strider@strycore.com"   #Change this to your email
export DEBFULLNAME="Mathieu Comandon"


# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="sorin"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git python pip django command-not-found rails ruby git vundle zsh-syntax-highlighting fabric yum grunt)


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

# Customize to your needs...
PATH=$HOME/bin:/usr/lib/lightdm/lightdm:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games

if [ -e /usr/bin/ack-grep ]; then
    alias ack="ack-grep"
fi
alias sfba="./symfony doctrine:build --all --and-load --no-confirmation"
alias sfbt="./symfony doctrine:build --all --and-load=test/fixtures --no-confirmation --env=test"
alias image_reduce="find . -size +2M -name '*.jpg' -exec convert -resize 33% {} {} \;"
alias epubcheck="java -jar /opt/epubcheck-3.0b5/epubcheck-3.0b5.jar"
alias nuke='tr -dc " _" < /dev/urandom'

deploy() {
    cwd=$(pwd)
    if [ ! -e fabfile.py ]; then
        cd ..
        if [ ! -e fabfile.py ]; then
            echo "No fabfile found"
            return -2
        fi
    fi
    fab staging deploy --password="$(cat ~/.django.password)"
    cd $cwd
    unset $cwd
}

say() {
    if [[ "${1}" =~ -[a-z]{2} ]]; then
        local lang=${1#-};
        local text="${*#$1}";
    else
        local lang=${LANG%_};
        local text="${1}";
    fi;
    mplayer "http://translate.google.com/translate_tts?ie=UTF-8&tl=${lang}&q=${text}"
}


export PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting


ubuntu_venvwrapper="/etc/bash_completion.d/virtualenvwrapper"
if [ -f $ubuntu_venvwrapper ]; then
    source $ubuntu_venvwrapper
else
    virtualenv=$(which virtualenvwrapper.sh)
    if [ "$virtualenv" != "" ]; then
        source $virtualenv
    fi
fi

# RVM Configuration: Load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"


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


function dj {
    PROJECT=$1 tmux -f $HOME/.tmux.django.conf attach
}

# Author: Julien Phalip
# License: BSD
# Description: Change the current directory to the path of the given Python package.

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
