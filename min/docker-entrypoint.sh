#!/bin/sh
chown -R postgres "$PG_DATA"

if [ -z "$(ls -A "$PG_DATA")" ]; then
    gosu postgres initdb
    sed -ri "s/^#(listen_addresses\s*=\s*)\S+/\1'*'/" "$PG_DATA"/postgresql.conf

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
    echo


    if [ "$PG_DB_NAME" != 'postgres' ]; then
      createSql="CREATE DATABASE $PG_DB_NAME;"
      echo $createSql | gosu postgres postgres --single -jE
      echo
    fi

    if [ "$PG_USER" != 'postgres' ]; then
      op=CREATE
    else
      op=ALTER
    fi

    userSql="$op USER $PG_USER WITH SUPERUSER $pass;"
    echo $userSql | gosu postgres postgres --single -jE
    echo

    # internal start of server in order to allow set-up using psql-client
    # does not listen on TCP/IP and waits until start finishes
    gosu postgres pg_ctl -D "$PG_DATA" \
        -o "-c listen_addresses=''" \
        -w start

    echo
    for f in /docker-entrypoint-initdb.d/*; do
        case "$f" in
            *.sh)  echo "$0: running $f"; . "$f" ;;
            *.sql) echo "$0: running $f"; psql --username "$PG_USER" --dbname "$PG_DB_NAME" < "$f" && echo ;;
            *)     echo "$0: ignoring $f" ;;
        esac
        echo
    done

    gosu postgres pg_ctl -D "$PG_DATA" -m fast -w stop

    { echo; echo "host all all 0.0.0.0/0 $authMethod"; } >> "$PG_DATA"/pg_hba.conf
fi

exec gosu postgres "$@"
