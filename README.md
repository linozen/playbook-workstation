# Provisioning of my Debain workstation

## Usage

### GPG Keys

First, install a couple of essential packages:

```shell
sudo apt-get update
sudo apt-get install gnupg2 git curl
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

### SSH Keys

Second, generate a new SSH key for the new machine's user account

```bash
ssh-keygen -t ed25519 -C "<username>@<new_host>"
```

Next, proceed to add the public part of this key wherever you need it.

### Restore from Backup

Third, I restore my important files from Backup and enable backups for the new
host. To set up automated backups using `borgmatic` on
[BorgBase](https://borgbase.com), simply run the corresponding role in this
playbook

```bash
ansible-playbook --ask-become-pass playbook.yml --tags backup
```
