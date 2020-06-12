#!/bin/bash

set -e

export MONGO_URI=${MONGO_URI:-mongodb://mongo:27017}
export MONGO_NAME=${MONGO_NAME:-mongo}
export MONGO_URI_2=$MONGO_URI_2
export MONGO_NAME_2=$MONGO_NAME_2
export MONGO_URI_3=$MONGO_URI_3
export MONGO_NAME_3=$MONGO_NAME_3
export MONGO_URI_4=$MONGO_URI_4
export MONGO_NAME_4=$MONGO_NAME_4

# Optional env vars:
# - CRON_SCHEDULE

if [[ "$CRON_SCHEDULE" ]]; then

    LOGFIFO='/var/log/cron.fifo'
    if [[ ! -e "$LOGFIFO" ]]; then
        mkfifo "$LOGFIFO"
    fi
    echo -e "#BACKUP SCRIPT CRONJOBS\n" > new_cron.txt
    echo "MONGO_URI=$MONGO_URI" >> new_cron.txt
    echo "MONGO_NAME=$MONGO_NAME" >> new_cron.txt
    echo "MONGO_URI_2=$MONGO_URI_2" >> new_cron.txt
    echo "MONGO_NAME_2=$MONGO_NAME_2" >> new_cron.txt
    echo "MONGO_URI_3=$MONGO_URI_3" >> new_cron.txt
    echo "MONGO_NAME_3=$MONGO_NAME_3" >> new_cron.txt
    echo "MONGO_URI_4=$MONGO_URI_4" >> new_cron.txt
    echo "MONGO_NAME_4=$MONGO_NAME_4" >> new_cron.txt
    echo "$CRON_SCHEDULE /backup.sh > $LOGFIFO 2>&1" >> new_cron.txt

    if [[ "$REMOVE_AFTER" ]]; then
       echo "0 4 * * * find /backup/* -mtime +$REMOVE_AFTER -type f -delete > $LOGFIFO 2>&1" >> new_cron.txt
    fi

    cron new_cron.txt

    tail -f "$LOGFIFO"
else
    exec /backup.sh
fi
