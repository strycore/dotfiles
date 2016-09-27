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
