# Provisioning a Reproducible Workstation with Pop OS 21.04

WIP

## Motivation

<!-- TODO Write and link to blogpost -->
<!-- TODO Add screenshots -->

## Usage

First, install a couple of essential packages:

```shell
sudo apt-get update
sudo apt-get install gnupg2 git curl ansible
```

### Setup GnuPG

<!-- TODO Rework with Yubikeys -->

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

<!-- TODO Rework with Yubikeys -->

Second, generate a new SSH key for the new machine's user account

```bash
ssh-keygen -t ed25519 -C "<username>@<new_host>"
```

Next, proceed to add the public part of this key wherever you need it.

### Install base Packages

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

Now, just to check whether everything is working, you can uninstall the global
`ansible` and reinstall it as a dependency of this project using `pipenv` (which
should have autmatically been installed in the Python version managed by
`asdf`):

```bash
sudo apt-get remove ansible
asdf reshim
pipenv install
pipenv run ansible --version
```

### Setup Doom Emacs

Sixth, you need [Doom Emacs](https://github.com/hlissner/doom-emacs). The
following command will set it up for you:

```bash
pipenv run ansible-playbook --ask-become-pass playbook.yml --tags emacs
```

I restored my `~/.doom.d` directory from backup, so you would need to do the same if
you don't want to start from a blank slate.

If you want to enable `mu4e` to read your e-mail within Doom Emacs and are on
Debian, chances are you need to install it from source. In order to do that,
simply run:

```bash
pipenv run ansible-playbook --ask-become-pass playbook.yml --tags emacs,mu4e
```

### Setup Gnome

The next two steps concern the Desktop Environment that we use, namely Gnome.

#### Extensions

First, we setup all the extensions we need. Simply look for the extension ID
(found in the URL of the extension on https://extensions.gnome.org) and add it
to the variable `gnome_extension_ids` [over here](host_vars/localhost.yaml).

#### Further Configuration

Since I'm lazy I dumped most of my configuration via `dconf dump /` and the role
in this playbook, among some other tiny things, simply loads this config dump.
In addition it adds a [nice dark
theme](https://gitlab.com/tista500/plata-theme) and a [cool
background](roles/ansible-gnome-config/files/space.png).

To apply all of this, simply run:

```bash
pipenv run ansible-playbook --ask-become-pass playbook.yml --tags gnome
```

### Install Docker in Rooless Mode

Docker is a real pleasure to use when you know it's capabilities are restricted
to your local user and not `root`. Simply run:

```bash
curl -fsSL https://get.docker.com/rootless | zsh
```

to install Docker in rootless mode. For more information, see [here](https://docs.docker.com/engine/security/rootless/).

### Mounting things

Sometimes, I mount a couple of NFS and a CIFS share. All the variables to do this
are also found [here](host_vars/localhost.yaml). To mount the shares, simply
run:

```bash
pipenv run ansible-playbook --ask-become-pass playbook.yml --tags mount
```
