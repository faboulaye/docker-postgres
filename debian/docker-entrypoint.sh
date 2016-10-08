#!/bin/sh

set -e

echo "host all  all    0.0.0.0/0  md5" >> $PGDATA/main/pg_hba.conf
echo "listen_addresses='*'" >> $PGDATA/main/postgresql.conf
/etc/init.d/postgresql start
psql -c "CREATE USER $PG_USER WITH SUPERUSER PASSWORD '$PG_PASSWORD';"
createdb -O $PG_USER $PG_DB_NAME
