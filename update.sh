#!/usr/bin/env bash

set -euo pipefail

TARGET_DIR=host_vars
TARGET_FILE=host_vars/"$HOSTNAME".yml
GNOME_CONF_DIR=files/gnome

echo "Recreating $TARGET_FILE"
rm -rf "$TARGET_FILE"
mkdir -p "$TARGET_DIR"

echo "Dumping Gnome shell configuration ..."
dconf dump /org/gnome/shell/ > "$GNOME_CONF_DIR"/shell.ini
dconf dump /org/gnome/desktop/ > "$GNOME_CONF_DIR"/desktop.ini

echo "Updating installed flatpaks ..."
cat << EOF >> $TARGET_FILE
---
flatpaks:
EOF

flatpak list --app --columns=app | head | sed 's/^/  - /' >> "$TARGET_FILE"

echo "Updating installed packages ..."
cat << EOF >> $TARGET_FILE

pkgs_to_install:
EOF

dpkg-query -f '  - ${Package}\n' -W >> "$TARGET_FILE"

echo "Removing packages from list that should not be there ..."

grep -v "linux-image" "$TARGET_FILE" > tmpfile && mv tmpfile "$TARGET_FILE"
grep -v "linux-headers" "$TARGET_FILE" > tmpfile && mv tmpfile "$TARGET_FILE"
grep -v "linux-modules" "$TARGET_FILE" > tmpfile && mv tmpfile "$TARGET_FILE"
grep -v "nvidia-driver" "$TARGET_FILE" > tmpfile && mv tmpfile "$TARGET_FILE"
grep -v "nvidia-kernel" "$TARGET_FILE" > tmpfile && mv tmpfile "$TARGET_FILE"
grep -v "language-pack-gnome" "$TARGET_FILE" > tmpfile && mv tmpfile "$TARGET_FILE"

echo "Add packages to be removed ..."
cat << EOF >> "$TARGET_FILE"

pkgs_to_remove:
  - anthy
  - fcitx
  - fcitx-bin
  - fcitx-data
  - fcitx-modules
  - fcitx-table
  - fortune-mod
  - firefox-locale-ar
  - firefox-locale-de
  - firefox-locale-es
  - firefox-locale-fr
  - firefox-locale-it
  - firefox-locale-ja
  - firefox-locale-pt
  - firefox-locale-ru
  - firefox-locale-zh-hans
  - firefox-locale-zh-hant
  - geary
  - gnome-boxes
  - gnome-games
  - gnome-getting-started-docs
  - gnome-getting-started-docs-de
  - gnome-getting-started-docs-es
  - gnome-getting-started-docs-fr
  - gnome-getting-started-docs-it
  - gnome-getting-started-docs-ja
  - gnome-getting-started-docs-pt
  - gnome-getting-started-docs-ru
  - gnome-getting-started-docs-zh-hk
  - gnome-getting-started-docs-zh-tw
  - gnome-user-docs-de
  - gnome-user-docs-es
  - gnome-user-docs-fr
  - gnome-user-docs-it
  - gnome-user-docs-ja
  - gnome-user-docs-pt
  - gnome-user-docs-ru
  - gnome-user-docs-zh-hans
  - goldendict
  - hdate
  - hdate-applet
  - hunspell-es
  - hunspell-fr
  - hunspell-fr-classical
  - hunspell-it
  - hunspell-pt-br
  - hunspell-pt-pt
  - hunspell-ru
  - ibus-libpinyin
  - kasumi
  - khmerconverter
  - language-pack-ar
  - language-pack-ar-base
  - language-pack-es
  - language-pack-es-base
  - language-pack-fr
  - language-pack-fr-base
  - language-pack-gnome-ar
  - language-pack-gnome-ar-base
  - language-pack-gnome-es
  - language-pack-gnome-es-base
  - language-pack-gnome-fr
  - language-pack-gnome-fr-base
  - language-pack-gnome-it
  - language-pack-gnome-it-base
  - language-pack-gnome-ja
  - language-pack-gnome-ja-base
  - language-pack-gnome-pt
  - language-pack-gnome-pt-base
  - language-pack-gnome-ru
  - language-pack-gnome-ru-base
  - language-pack-gnome-zh-hans
  - language-pack-gnome-zh-hans-base
  - language-pack-gnome-zh-hant
  - language-pack-gnome-zh-hant-base
  - language-pack-it
  - language-pack-it-base
  - language-pack-ja
  - language-pack-ja-base
  - language-pack-pt
  - language-pack-pt-base
  - language-pack-ru
  - language-pack-ru-base
  - language-pack-zh-hans
  - language-pack-zh-hans-base
  - language-pack-zh-hant
  - language-pack-zh-hant-base
  - libreoffice-help-common
  - libreoffice-help-de
  - libreoffice-help-en-gb
  - libreoffice-help-en-us
  - libreoffice-help-es
  - libreoffice-help-fr
  - libreoffice-help-it
  - libreoffice-help-ja
  - libreoffice-help-pt
  - libreoffice-help-pt-br
  - libreoffice-help-ru
  - libreoffice-help-zh-cn
  - libreoffice-help-zh-tw
  - libreoffice-impress
  - libreoffice-l10n-ar
  - libreoffice-l10n-es
  - libreoffice-l10n-fr
  - libreoffice-l10n-it
  - libreoffice-l10n-ja
  - libreoffice-l10n-pt
  - libreoffice-l10n-pt-br
  - libreoffice-l10n-ru
  - libreoffice-l10n-zh-cn
  - libreoffice-l10n-zh-tw
  - mlterm
  - mlterm-tiny
  - mozc-data
  - mozc-server
  - mozc-utils
  - rhythmbox
  - uim-mozc
  - xiterm+thai
  - xterm
EOF
