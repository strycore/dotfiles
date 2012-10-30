
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

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git python pip django command-not-found rails ruby git zsh-syntax-highlighting)


source $ZSH/oh-my-zsh.sh
# Disable autocorrect
unsetopt correct_all

# Customize to your needs...
PATH=$HOME/bin:/usr/lib/lightdm/lightdm:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games

# Workaround for bug #776499
function gvim () { /usr/bin/gvim -f $* & }

alias sfba="./symfony doctrine:build --all --and-load --no-confirmation"
alias sfbt="./symfony doctrine:build --all --and-load=test/fixtures --no-confirmation --env=test"
alias image_reduce="find . -size +2M -name '*.jpg' -exec convert -resize 33% {} {} \;"

if [ -e "$(which ls++)" ]; then
    alias ls=ls++
fi

export PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
#
# VirtualenvWrapper configuration
virtualenv=$(which virtualenvwrapper.sh)
if [ "$virtualenv" != "" ]; then
    export WORKON_HOME=$HOME/.virtualenvs
    export PROJECT_HOME=$HOME/Projects
    source $virtualenv
fi

# RVM Configuration: Load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

export PERL_LOCAL_LIB_ROOT="/home/strider/perl5";
export PERL_MB_OPT="--install_base /home/strider/perl5";
export PERL_MM_OPT="INSTALL_BASE=/home/strider/perl5";
export PERL5LIB="/home/strider/perl5/lib/perl5/x86_64-linux-gnu-thread-multi:/home/strider/perl5/lib/perl5";
export PATH="/home/strider/perl5/bin:$PATH";

export PERL_LOCAL_LIB_ROOT="/home/strider/perl5";
export PERL_MB_OPT="--install_base /home/strider/perl5";
export PERL_MM_OPT="INSTALL_BASE=/home/strider/perl5";
export PERL5LIB="/home/strider/perl5/lib/perl5/x86_64-linux-gnu-thread-multi:/home/strider/perl5/lib/perl5";
export PATH="/home/strider/perl5/bin:$PATH";
