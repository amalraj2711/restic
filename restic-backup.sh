#!/bin/bash
BASE_DIR="$(cd "$(dirname "$0")" && pwd)"
SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"

2>&1

echo "Running Restic backup script for $USER on `date`"

# Import the configuration settings.
source $SCRIPT_DIR/restic-env.sh

# Run the backup on locations mentioned below
restic backup                \
    /home/      \

# Remove old backups. Enable if your REST server is not in append only mode.
#restic forget           \
#       --keep-hourly 8  \
#       --keep-daily 7   \
#       --keep-weekly 4  \
#       --keep-monthly 6 \
#       --keep-yearly 10

# check that the backup is ok
restic check

# reset credentials
unset RESTIC_REPOSITORY
unset RESTIC_PASSWORD

exit 0
