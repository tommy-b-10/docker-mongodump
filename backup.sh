#!/bin/bash

set -e

echo "Job started: $(date)"

DATE=$(date +%Y%m%d_%H%M%S)
ls /backup/$MONGO_NAME 2>/dev/null||mkdir /backup/$MONGO_NAME
FILE="/backup/$MONGO_NAME/backup-$DATE.tar.gz"
mkdir -p dump
mongodump --uri "$MONGO_URI"
tar -zcvf "$FILE" dump/
rm -rf dump/

if [[ "$MONGO_URI_2" ]]; then
    ls /backup/$MONGO_NAME_2 2>/dev/null||mkdir /backup/$MONGO_NAME_2
    FILE="/backup/$MONGO_NAME_2/backup-$DATE.tar.gz"
    mkdir -p dump
    mongodump --uri "$MONGO_URI_2"
    tar -zcvf "$FILE" dump/
    rm -rf dump/
fi
if [[ "$MONGO_URI_3" ]]; then
    ls /backup/$MONGO_NAME_3 2>/dev/null||mkdir /backup/$MONGO_NAME_3
    FILE="/backup/$MONGO_NAME_3/backup-$DATE.tar.gz"
    mkdir -p dump
    mongodump --uri "$MONGO_URI_3"
    tar -zcvf "$FILE" dump/
    rm -rf dump/
fi
if [[ "$MONGO_URI_4" ]]; then
    ls /backup/$MONGO_NAME_4 2>/dev/null||mkdir /backup/$MONGO_NAME_4
    FILE="/backup/$MONGO_NAME_4/backup-$DATE.tar.gz"
    mkdir -p dump
    mongodump --uri "$MONGO_URI_4"
    tar -zcvf "$FILE" dump/
    rm -rf dump/
fi

echo "Job finished: $(date)"
