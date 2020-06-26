# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


# == Default programs
export EDITOR='gvim'
export BROWSER='firefox'
export PYTHONIOENCODING=UTF-8

export EMAIL="strider@strycore.com"
export FULLNAME="Mathieu Comandon"

# == Debian packaging variables
export DEBEMAIL=$EMAIL
export DEBFULLNAME=$FULLNAME

export LANG="en_US.UTF-8"
export TERM="xterm-256color"

ZSH=$HOME/.oh-my-zsh
ZSH_THEME="powerlevel10k/powerlevel10k"
DISABLE_UPDATE_PROMPT=true

# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
plugins=(git command-not-found zsh-syntax-highlighting fabric bower aws)
source $ZSH/oh-my-zsh.sh

# Disable autocorrect
unsetopt correct_all

export PATH=$PATH:$HOME/.local/bin/
if [ -s $HOME/.rvm/bin ]; then
    export PATH=$PATH:$HOME/.rvm/bin
fi

# Start Gnome Keyring daemon on other DE's than Gnome (or simply when it's
# having a bad day)
if [ -n "$DESKTOP_SESSION" -a -z "$SSH_AUTH_SOCK" ]; then
    eval $(gnome-keyring-daemon --start --components=ssh)
    export SSH_AUTH_SOCK
fi

if [ -x "$HOME/.mancolor" ]; then
    source $HOME/.mancolor
fi

if [ -e "$HOME/.profile" ]; then
    source $HOME/.profile
fi

# NVM support
export NVM_DIR="$HOME/.nvm"
if [ -s "$NVM_DIR/nvm.sh" ]; then
   source "$NVM_DIR/nvm.sh"
   nvm use default > /dev/null
fi

# Virtualenvwrapper
if [ -f "/usr/share/virtualenvwrapper/virtualenvwrapper.sh" ]; then
    virtualenvwrapper="/usr/share/virtualenvwrapper/virtualenvwrapper.sh"
else
    virtualenvwrapper=$(which virtualenvwrapper.sh)
    if [[ -f "/usr/bin/python3" ]]; then
        export VIRTUALENVWRAPPER_PYTHON="/usr/bin/python3"
    elif [[ -f "/usr/local/bin/python3" ]]; then
        export VIRTUALENVWRAPPER_PYTHON="/usr/local/bin/python3"
    fi
fi
if [ -f "$virtualenvwrapper" ]; then
    source $virtualenvwrapper
fi

# RVM Configuration: Load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

alias image_reduce="find . -size +2M -name '*.jpg' -exec convert -resize 33% {} {} \;"
alias nuke='tr -dc " _" < /dev/urandom'
alias tmux='tmux -2'
alias lxls='sudo lxc-ls --fancy'
alias sockette='ssh -D 1337 -f -C -q -N strider@strycore.com'

function _top_level_packages {
    python -c "import pkgutil; print('\n'.join([name for loader, name, ispkg in sorted(pkgutil.iter_modules()) if ispkg]))"
}

_root_dir="$(dirname $(readlink ~/.zshrc))"
source $_root_dir/shell_functions.sh


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

# Unset this function from the git plugin, collides with `workon` tab completion
if [ "$(type work_in_progress)" ]; then
    unset -f work_in_progress
fi

# This is pretty much a port of the OhMyZsh Vundle plugin for vim-plug
function vim-plug-init () {
  if [ ! -d ~/.vim/autoload/ ]
  then
    mkdir -p ~/.vim/autoload/
  fi

  if [ ! -f ~/.vim/autoload/plug.vim ]
  then
    curl -fLo ~/.vim/autoload/plug.vim https://raw.github.com/junegunn/vim-plug/master/plug.vim
    echo "\n\tRead about vim configuration for vim-plug at https://github.com/junegunn/vim-plug\n"
  fi
}

function vim-plug () {
  vim-plug-init
  vim -c "execute \"PlugInstall\" | q | q"
}

function vim-plug-update () {
  vim-plug-init
  vim -c "execute \"PlugUpgrade\" | q | q"
  vim -c "execute \"PlugUpdate\" | q | q"
}

function vim-plug-clean () {
  vim-plug-init
  vim -c "execute \"PlugClean!\" | q | q"
}

# Autocompletion for npm and gulp
eval "$(npm completion 2>/dev/null)"
eval "$(gulp --completion=zsh 2>/dev/null)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
        source /etc/profile.d/vte*.sh
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
