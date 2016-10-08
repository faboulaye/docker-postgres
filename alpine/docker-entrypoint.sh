#!/bin/sh
set -e

if [ -z "$(ls -A "$PGDATA")" ]; then
    initdb
    sed -ri "s/^#(listen_addresses\s*=\s*)\S+/\1'*'/" "$PGDATA"/postgresql.conf

    : ${PG_USER:="postgres"}
    : ${PG_DB_NAME:=$PG_USER}

    if [ "$PG_PASSWORD" ]; then
      pass="PASSWORD '$PG_PASSWORD'"
      authMethod=md5
    else
      echo "==============================="
      echo "!!! Use \$PG_PASSWORD env var to secure your database !!!"
      echo "==============================="
      pass=
      authMethod=trust
    fi

    { echo; echo "host all all 0.0.0.0/0 $authMethod"; } >> "$PGDATA"/pg_hba.conf
    chown postgres:postgres $PGDATA/pg_hba.conf

    if [ "$PG_DB_NAME" != 'postgres' ]; then
      createSql="CREATE DATABASE $PG_DB_NAME;"
      echo $createSql | postgres --single -jE
      echo
    fi

    if [ "$PG_USER" != 'postgres' ]; then
      op=CREATE
    else
      op=ALTER
    fi

    userSql="$op USER $PG_USER WITH SUPERUSER $pass;"
    echo $userSql | postgres --single -jE
    echo

    pg_ctl -D "$PGDATA" -o "-c listen_addresses=''" -w start

    echo
    for f in /docker-entrypoint-initdb.d/*; do
        case "$f" in
            *.sh)  echo "$0: running $f"; . "$f" ;;
            *.sql) echo "$0: running $f"; psql --username "$PG_USER" --dbname "$PG_DB_NAME" < "$f" && echo ;;
            *)     echo "$0: ignoring $f" ;;
        esac
        echo
    done

    pg_ctl -D "$PGDATA" -m fast -w stop
    echo 'PostgreSQL initialize successfully !!!'
fi
postgres
