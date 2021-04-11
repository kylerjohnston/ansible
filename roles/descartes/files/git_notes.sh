#!/usr/bin/env bash
set -euo pipefail

echo $(date)

cd /home/krj/home-docs/notes

gstatus=$(git status --porcelain)

if [ ${#gstatus} -ne 0 ]; then
    git add -A
    git commit -m "$(date)"
    git pull --rebase
    git push origin main
  else
    git pull --rebase
fi

echo "Success"
