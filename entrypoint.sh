#!/bin/bash

set -e

export MONGO_URI=${MONGO_URI:-mongodb://mongo:27017}

# Optional env vars:
# - CRON_SCHEDULE
# - TARGET_S3_FOLDER
# - AWS_ACCESS_KEY_ID
# - AWS_SECRET_ACCESS_KEY

if [[ "$CRON_SCHEDULE" ]]; then
    LOGFIFO='/var/log/cron.fifo'
    if [[ ! -e "$LOGFIFO" ]]; then
        mkfifo "$LOGFIFO"
    fi
    CRON_ENV="MONGO_URI='$MONGO_URI'"
    echo -e "$CRON_ENV\n$CRON_SCHEDULE /backup.sh > $LOGFIFO 2>&1" | crontab -
    
    if [[ "$MONGO_URI_2" ]]; then
        echo -e "$MONGO_URI_2\n$CRON_SCHEDULE /backup.sh > $LOGFIFO 2>&1" | crontab -
    fi
    
    if [[ "$MONGO_URI_3" ]]; then
        echo -e "$MONGO_URI_3\n$CRON_SCHEDULE /backup.sh > $LOGFIFO 2>&1" | crontab -
    fi
    if [[ "$MONGO_URI_4" ]]; then
        echo -e "$MONGO_URI_4\n$CRON_SCHEDULE /backup.sh > $LOGFIFO 2>&1" | crontab -
    fi
    
    crontab -l
    cron
    tail -f "$LOGFIFO"
else
    exec /backup.sh
fi
