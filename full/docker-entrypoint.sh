#!/bin/sh

/etc/init.d/postgresql start psql --command "CREATE USER $PG_USER WITH SUPERUSER PASSWORD '$PG_PASSWORD';"
createdb -O $PG_USER $PG_DB_NAME
echo "host all  all    0.0.0.0/0  md5" >> /etc/postgresql/$PG_VERSION/main/pg_hba.conf
echo "listen_addresses='*'" >> /etc/postgresql/$PG_VERSION/main/postgresql.conf
