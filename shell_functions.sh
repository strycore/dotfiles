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
    /usr/bin/df "$@" | grep -v "^/dev/loop\|^tmpfs"
}

function mount {
    /usr/bin/mount "$@" | grep -v "^cgroup\|^tmpfs\|^/var/lib/snapd\|^nsfs|^overlay"
}

function surface6lodpi {
    xrandr --newmode "1368x912"  103.00  1368 1448 1592 1816  912 915 925 947 -hsync +vsync
    xrandr --addmode eDP-1 1368x912
}

function killwine {
    kill -9 $(ps -ef | grep -E -i '(wine|processid|\.exe)' | awk '{print $2}')
}