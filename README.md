# Provisioning of my Debain workstation

## Usage

### Setup GnuPG

First, install a couple of essential packages:

```shell
sudo apt-get update
sudo apt-get install gnupg2 git curl pipenv
```

Next, I restore my GPG keys using some simple scripts. See [this
gist](https://gist.github.com/chrisroos/1205934) for more information. One for
exporting (this needs to be run on a machine where you have you have `gpg2` set
up.)

```bash
#!/usr/bin/env bash
set -euo pipefail

cp ~/.gnupg/pubring.kbx .
cp ~/.gnupg/trustdb.gpg .

gpg2 --export --armor <yourkey@id> ><yourkey@id>.pub.asc
gpg2 --export-secret-keys --armor <yourkey@id> ><yourkey@id>.priv.asc
gpg2 --export-secret-subkeys --armor <yourkey@id> ><yourkey@id>.sub_priv.asc
gpg2 --export-ownertrust >ownertrust.txt
```

Then, on the new machine, simply import using the following

```bash
#!/usr/bin/env bash
set -euo pipefail

cp ./*.kbx ~/.gnupg/
cp ./*.gpg ~/.gnupg/

gpg2 --import <yourkey@id>.pub.asc
gpg2 --import <yourkey@id>.priv.asc
gpg2 --import <yourkey@id>.sub_priv.asc
# You only need to uncomment this if your trustdb became corrupted
# gpg2 --import-ownertrust ownertrust.txt
```

### Setup SSH Keys

Second, generate a new SSH key for the new machine's user account

```bash
ssh-keygen -t ed25519 -C "<username>@<new_host>"
```

Next, proceed to add the public part of this key wherever you need it.

### Install Packages

After cloning this repo, run the command below, to install all packages
specified in
[`roles/ansible-pkgs/tasks/main.yml`](roles/ansible-pkgs/tasks/main.yml) and
enable the third party repos specified in [`host_vars/localhost.yaml`](host_vars/localhost.yaml)

```bash
git clone --recurse-submodules https://github.com/linozen/playbook-workstation.git ~/Downloads/playbook-workstation
ansible-playbook --ask-become-pass playbook.yml --tags pkgs
```

### Restore from Backup

Fourth, I restore my important files from Backup and enable backups for the new
host. To set up automated backups using `borgmatic` on
[BorgBase](https://borgbase.com), simply run the corresponding role in this
playbook

```bash
ansible-playbook --ask-become-pass playbook.yml --tags backup
```

Then, you can either use `borgmatic` to restore your backup or a version of my
simple [borg backup extraction script](extractor.sh).

### Setup the Shell

Fifth, we setup `zsh` and `asdf`. For this to work flawlessly, make sure you
have clone the repo again into `~/Projects`.

```bash
rm -rf ~/Downloads/playbook-workstation
git clone --recurse-submodules https://github.com/linozen/playbook-workstation.git ~/Projects/playbook-workstation
ansible-playbook --ask-become-pass playbook.yml --tags shell
```

### Setup Doom Emacs

Sixth,
