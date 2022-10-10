#!/usr/bin/env bash
set -euo pipefail

gpg --batch --use-agent --decrypt passphrase.gpg
