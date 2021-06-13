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
if [[ $REPLY =~ ^[Yy]$ ]]; then
    cd /home/lino
    echo "Restoring ~/Exocortex..."
    borg extract --strip-components 2 --list -p "$BORG_PATH::$BACKUP" home/lino/Exocortex
fi

echo
read -p "Restore ~/Projects? " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    cd /home/lino
    echo "Restoring ~/Projects"
    borg extract --strip-components 2 --list -p "$BORG_PATH::$BACKUP" home/lino/Projects
fi

echo
read -p "Restore E-mails? " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    cd /home/lino
    echo "Restoring E-mails..."
    borg extract --strip-components 2 --list -p "$BORG_PATH::$BACKUP" home/lino/.evolution
    borg extract --strip-components 2 --list -p "$BORG_PATH::$BACKUP" home/lino/.mail
    borg extract --strip-components 2 --list -p "$BORG_PATH::$BACKUP" home/lino/.mbsyncrc
fi

echo
read -p "Restore Zotero data? " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    cd /home/lino
    echo "Restoring Zotero data..."
    borg extract --strip-components 2 --list -p "$BORG_PATH::$BACKUP" home/lino/.zotero
    borg extract --strip-components 2 --list -p "$BORG_PATH::$BACKUP" home/lino/Zotero
fi

echo
read -p "Restore .doom.d? " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    cd /home/lino
    echo "Restoring .doom.d..."
    borg extract --strip-components 2 --list -p "$BORG_PATH::$BACKUP" home/lino/.doom.d
fi
