function cron_environ ()
{
    # Export Gnome Keyring and SSH agent environment variables to a file so they
    # can be used by cron jobs.
    CRON_ENVIRON="$HOME/.cron/environ"
    touch $CRON_ENVIRON
    chmod 600 $CRON_ENVIRON
    env | grep DBUS_SESSION_BUS_ADDRESS > $CRON_ENVIRON
    echo 'export DBUS_SESSION_BUS_ADDRESS' >> $CRON_ENVIRON
    env | grep SSH_AUTH_SOCK >> $CRON_ENVIRON
    echo 'export SSH_AUTH_SOCK' >> $CRON_ENVIRON
}

function irc_log() {
    channel=$1
    today=$(date "+%Y-%m-%d")
    hostname="irc.strycore.com"
    logpath="/home/strider/.znc/moddata/log/strider/default/"
    destfile="${channel}-${today}.log"
    scp "$hostname:$logpath#$channel/$today.log" $destfile
    $EDITOR $destfile
}


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

function blitter() {
    yes "$(seq 231 -1 16)" | while read i; do
        printf "\x1b[48;5;${i}m\n";
        sleep .02;
    done
}

function fuck() {
  if [ -z "$2" ]; then
    kill -9 $(top -b -n1 -c  | awk '/PID *USER/{getline;print $1;getline;print $1}')
    echo ; echo " ┻━┻ ︵ヽ(\`Д´)ﾉ︵ ┻━┻ "; echo
  elif killall -9 "$2"; then
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
    cd $(dirname $(python -c "import pkgutil; print(pkgutil.get_loader('$1').get_filename())"))
}

function greball {
    git for-each-ref 'refs/heads/*' | \
    while read rev type ref; do
        branch=$(expr "$ref" : 'refs/heads/\(.*\)' )
        revs=$(git rev-list $rev..master)
        if [ -n "$revs" ]; then
        git checkout $branch; git rebase --strategy=ours master; g rebase
        fi
    done
}

function gfetall {
    git checkout master
    git fetch --all
    git rebase upstream/master
}

function df {
    /bin/df "$@" | grep -v "^/dev/loop\|^tmpfs"
}

function mount {
    /bin/mount "$@" | grep -v "^cgroup\|^tmpfs\|^/var/lib/snapd\|^nsfs|^overlay"
}

function surface6lodpi {
    xrandr --newmode "1368x912"  103.00  1368 1448 1592 1816  912 915 925 947 -hsync +vsync
    xrandr --addmode eDP-1 1368x912
}
