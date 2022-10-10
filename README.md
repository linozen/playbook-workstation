# A Reproducible Workstation based on Pop!_OS

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

