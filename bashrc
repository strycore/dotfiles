[ -z "$PS1" ] && return

# == Bash history
export HISTFILESIZE=100000000
export HISTSIZE=100000
export HISTIGNORE="cd:ls:[bf]g:clear:exit"
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups

# == Default programs
export EDITOR='vim'      # Default text editor
export BROWSER='firefox' # Default web browser

# == Debian packaging variables
export DEBEMAIL="strider@strycore.com"   #Change this to your email
export DEBFULLNAME="Mathieu Comandon"

# == Ubuntu specific
# Uncomment the following line to deactivate Ubuntu's global menu
#export UBUNTU_MENUPROXY=0
# Uncomment the following line to remove the battery indicator in wingpanel
#export UNITY_PANEL_INDICATORS_SKIP="libpower.so"

# == Bash options
shopt -s cdspell # Correct minor spelling errors in directories
#shopt -s dirspell # Attempt autocompletion for directories
shopt -s checkwinsize # Update window size between each commands
complete -cf sudo #tab complete for sudo
set -o noclobber # prevent overwriting files with cat


# ==Misc
# Make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi
# Add ~/bin to path
if [ -d "$HOME/bin" ] ; then
    export PATH="$HOME/bin:$PATH"
fi

# == Prompt configuration
force_color_prompt=yes
if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        color_prompt=yes
    else
        color_prompt=
    fi
fi
case "$TERM" in
    xterm-color|xterm) color_prompt=yes;;
esac

if [ "$color_prompt" = yes ]; then
    # Clock and one line
    #PS1="(\[\e[0;37m\]\A\[\e[0;37m\]) \[\e[0;32m\]\u@\h\[\e[0;37m\]:\[\e[0;36m\]\w\[\e[0;37m\] \$ "
    # Dumb prompt
    # PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
    # Directory on one line, user on another
    #PS1='\[\033[01;31m\]\w\[\033[00m\]\n${debian_chroot:+($debian_chroot)}\[\033[01;34m\]\u\[\033[01;32m\]@\[\033[01;34m\]\h\[\033[00m\]\$ '
    # Directory on one line, user on another
    PS1='(\[\e[0;37m\]\A\[\e[0;37m\]) \[\033[01;31m\]\w\[\033[00m\]\n${debian_chroot:+($debian_chroot)}\[\033[01;34m\]\u\[\033[01;32m\]@\[\033[01;34m\]\h\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi
alias ls='ls -hp'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias l='ls -lha'
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'
alias ..='cd ..'
alias cd..='cd ..'
alias back='cd $OLDPWD'
alias df='df -h'
alias du='du -h -c'
alias hosts='$EDITOR /etc/hosts'
alias alert_helper='history|tail -n1|sed -e "s/^\s*[0-9]\+\s*//" -e "s/;\s*alert$//"'
alias alert='notify-send -i /usr/share/icons/gnome/32x32/apps/gnome-terminal.png "[0] "'
# Start urxvt and do whatever is needed to open the screen session named "main"
alias scrux="screen -ls | grep main && urxvt -name screen -e screen -x main || urxvt -name screen -e screen -R -S main"
# Symfony aliases
alias sfba="./symfony doctrine:build --all --and-load --no-confirmation"
alias sfbt="./symfony doctrine:build --all --and-load=test/fixtures --no-confirmation --env=test"
alias ohshit="find ~/.mozilla/firefox/*.default/*.sqlite -exec sqlite3 {} 'VACUUM;' \;"
alias djrep="grep -r --exclude=tags --exclude=PYSMELLTAGS"

function search ()
{
    for i in "$@"; do
        ( find -iname "*$i*" | grep -i "$i" --color=auto ) 2> /dev/null;
    done
}


PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

# VirtualenvWrapper configuration
virtualenv=$(type -P virtualenvwrapper.sh)
if [ "$virtualenv" != "" ]; then
    export WORKON_HOME=$HOME/Projects/virtualenvs
    source $virtualenv
fi
# RVM Configuration: Load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
# Bash completion
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi
