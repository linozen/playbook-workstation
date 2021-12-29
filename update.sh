#!/usr/bin/env bash

set -euo pipefail

TARGET_DIR=host_vars
GNOME_CONF_DIR=files/gnome

echo "Dumping Gnome shell configuration ..."
dconf dump /org/gnome/shell/ > "$GNOME_CONF_DIR"/"$HOSTNAME"-shell.ini
dconf dump /org/gnome/desktop/ > "$GNOME_CONF_DIR"/"$HOSTNAME"-desktop.ini
