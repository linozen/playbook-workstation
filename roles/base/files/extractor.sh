#!/usr/bin/env bash
# to be run by root
set -euo pipefail

# excuse my shell-fu
read -p 'Where is the backup: ' path

stty -echo
printf "Give me the password: "
read password
stty echo
printf "\n"

export BORG_PATH="$path"
export BORG_PASSPHRASE="$password"

# this can obviously be done more elegantly
# list last 5 backups 
echo
borg list --last 5 --short $BORG_PATH
echo

read -p "Which of the above do you want to restore? Type in full name: " backup

export BACKUP="$backup"

echo "This is the backup you are about to restore:"
echo
echo "$BORG_PATH::$BACKUP"
echo
read -p "Restore Exocortex? " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
    cd /home/lino
    echo "Restoring ~/Exocortex..."
    borg extract --strip-components 2 --list -p $BORG_PATH::$BACKUP home/lino/Exocortex
fi

echo
read -p "Restore ~/.dotfiles? " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
    cd /home/lino
    echo "Restoring ~/.dotfiles and creating symlinks..."
    borg extract --strip-components 2 --list -p $BORG_PATH::$BACKUP home/lino/.dotfiles
fi

echo
read -p "Restore E-mails? " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
    cd /home/lino
    echo "Restoring E-mails..."
    borg extract --strip-components 2 --list -p $BORG_PATH::$BACKUP home/lino/.evolution
    borg extract --strip-components 2 --list -p $BORG_PATH::$BACKUP home/lino/.mail
fi

echo
read -p "Restore fish_history to Downloads? " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
    cd /home/lino/Downloads
    echo "Restoring fish_history to ~/Downloads..."
    borg extract --strip-components 5 --list -p $BORG_PATH::$BACKUP home/lino/.local/share/fish/fish_history
fi
