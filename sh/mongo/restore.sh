#!/bin/bash

set -e # if the script fail this command will out of script

source .env ## to read .env file

# docker exec -it mongo-container mongorestore --batchSize=10 --numInsertionWorkersPerCollection 1 -u $MONGO_USER -p $MONGO_PASSWORD --db $MONGO_DB_NAME $MONGO_BACKUP_FOLDER --drop --noIndexRestore # backup into container

# Itera sobre cada arquivo BSON no diretório de backup
for file in ${MONGO_BACKUP_FOLDER}/*.bson; do
  # Extrai o nome da coleção a partir do nome do arquivo
  collection=$(basename "$file" .bson)
  
  echo "Restaurando a coleção: $collection"
  
  # Executa o comando mongorestore para restaurar a coleção
  docker exec -it mongo-container mongorestore --batchSize=10 --numInsertionWorkersPerCollection 1 \
    -u $MONGO_USER -p $MONGO_PASSWORD --db $MONGO_DB_NAME --collection $collection --drop --noIndexRestore "$file"
  
  echo "Coleção $collection restaurada."
done

echo "Restauração completa."