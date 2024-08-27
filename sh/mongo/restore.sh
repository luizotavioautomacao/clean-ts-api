#!/bin/bash

set -e # if the script fail this command will out of script

source .env ## to read .env file

# docker-compose up -d mongo
# sleep 10

docker exec -it mongo-container mongorestore --batchSize=10 -u $MONGO_USER -p $MONGO_PASSWORD --db $MONGO_DB_NAME $MONGO_BACKUP_FOLDER --drop --noIndexRestore # backup into container

# docker-compose down