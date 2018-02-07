#!/bin/sh

set -eu

MYSQL_HOST_OPTS="-h $MYSQL_HOST -P $MYSQL_PORT -u$MYSQL_USER -p$MYSQL_PASSWORD"
databases=$(mysql $MYSQL_HOST_OPTS -e 'SHOW DATABASES;' --silent)

for database in $databases
do
  if [ "$database" != "information_schema" ]
  then
    echo "Creating backup for $database..."
    echo mysqldump $MYSQL_HOST_OPTS $MYSQLDUMP_OPTIONS $database
    mysqldump $MYSQL_HOST_OPTS $MYSQLDUMP_OPTIONS $database > /sql/$database.sql 
    curl -X POST "https://content.dropboxapi.com/2/files/upload" \
             -H "Authorization: Bearer $DROPBOX_ACCESS_TOKEN" \
             -H 'Content-Type: application/octet-stream' \
             -H "Dropbox-API-Arg: {\"path\":\"/$DROPBOX_PREFIX$database.sql\", \"mode\": \"overwrite\"}" \
             -d @"/sql/$DROPBOX_PREFIX$database.sql"
  fi
done