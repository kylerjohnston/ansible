#!/usr/bin/env bash
set -euo pipefail

cd /home/krj/home-docs/notes
if ! $(git status | grep 'nothing to commit'); then
    git add -A
    git commit -m "$(date)"
    git push origin main
fi
