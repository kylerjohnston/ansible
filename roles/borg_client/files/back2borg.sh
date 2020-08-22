#!/bin/sh
# Run like:
# back2borg.sh user@host:/path/to/borg/repo
#

if [ $# -eq 0 ]; then
    echo "ERROR: Requires path to borg repo."
    echo "Run like: ./back2spinoza.sh user@host:/path/to/borg/repo"
    exit 1
fi

# Setting this, so the repo does not need to be given on the commandline:
export BORG_REPO="$1"

# Setting this, so you won't be asked for your repository passphrase:
#export BORG_PASSPHRASE='XYZl0ngandsecurepa_55_phrasea&&123'
# or this to ask an external program to supply the passphrase:
#export BORG_PASSCOMMAND='pass show backup'

DATE=$(/usr/bin/date +%Y-%m-%d-%H:%M)

# some helpers and error handling:
info() { printf " \n%s %s\n\n" "$( date )" "$*" >&2; }
trap 'echo $( date ) Backup interrupted >&2; exit 2' INT TERM

info "Starting backup to $1"

# Backup the most important directories into an archive named after
# the machine this script is currently running on:

borg create                         \
    --verbose                       \
    --filter AME                    \
    --list                          \
    --stats                         \
    --show-rc                       \
    --compression lz4               \
    --exclude-caches                \
    --exclude "$HOME/.ansible*" \
    --exclude "$HOME/.bash*" \
    --exclude "$HOME/.cache"  \
    --exclude "$HOME/.local/share/containers" \
    --exclude "$HOME/.local/share/Steam" \
    --exclude "$HOME/config" \
    --exclude "$HOME/.config/google-chrome" \
    --exclude "$HOME/Desktop" \
    --exclude "$HOME/.doom.d" \
    --exclude "$HOME/dot-files" \
    --exclude "$HOME/Downloads" \
    --exclude "$HOME/.emacs.d" \
    --exclude "$HOME/.esd_auth" \
    --exclude "$HOME/FiraxisLive" \
    --exclude "$HOME/.gitconfig" \
    --exclude "$HOME/iso" \
    --exclude "$HOME/.java" \
    --exclude "$HOME/.mozilla" \
    --exclude "$HOME/.pandoc" \
    --exclude "$HOME/.pki" \
    --exclude "$HOME/Public" \
    --exclude "$HOME/.racket" \
    --exclude "$HOME/snap" \
    --exclude "$HOME/.steam*" \
    --exclude "$HOME/Templates" \
    --exclude "$HOME/.tex*" \
    --exclude "$HOME/tmp" \
    --exclude "$HOME/.vim*" \
    --exclude "$HOME/VMs" \
    $BORG_REPO::$DATE            \
    $HOME

backup_exit=$?

info "Pruning repository"

# Use the `prune` subcommand to maintain 7 daily, 4 weekly and 6 monthly
# archives of THIS machine. The '{hostname}-' prefix is very important to
# limit prune's operation to this machine's archives and not apply to
# other machines' archives also:

borg prune                          \
    --list                          \
    --prefix '{hostname}-'          \
    --show-rc                       \
    --keep-daily    7               \
    --keep-weekly   4               \
    --keep-monthly  6               \

prune_exit=$?

# use highest exit code as global exit code
global_exit=$(( backup_exit > prune_exit ? backup_exit : prune_exit ))

if [ ${global_exit} -eq 1 ];
then
    info "Backup and/or Prune finished with a warning"
    global_exit=0 # this is a hack to suppress a warning causing my systemd service to fail
fi

if [ ${global_exit} -gt 1 ];
then
    info "Backup and/or Prune finished with an error"
fi

exit ${global_exit}
