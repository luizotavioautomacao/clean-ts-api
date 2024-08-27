#!/bin/bash

# create user admin
set -e

mongo -u $MONGO_USER -p $MONGO_PASSWORD <<EOF

use $MONGO_DB_NAME
db.createUser({ 
    user: "$MONGO_USER", 
    pwd: "$MONGO_PASSWORD", 
    roles: [{ 
        role: "readWrite", 
        db: "$MONGO_DB_NAME" 
    }]
})