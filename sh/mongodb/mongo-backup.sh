#!/bin/bash

set -e # if the script fail this command will out of script

source .env ## to read .env file

docker exec -it mongo_service mongodump -u $MONGO_USER -p $MONGO_PASSWORD --db $MONGO_DB_NAME $MONGO_BACKUP_FOLDER --out $MONGO_BACKUP_FOLDER