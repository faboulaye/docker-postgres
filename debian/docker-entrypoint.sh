#!/bin/sh -e

initdb -D $PGDATA -E $PG_ENCODING

grep "host all  all    0.0.0.0/0  md5" $PGDATA/pg_hba.conf
 && echo "host all  all    0.0.0.0/0  md5" >> $PGDATA/pg_hba.conf
grep "listen_addresses='*'" $PGDATA/postgresql.conf
  && echo "listen_addresses='*'" >> $PGDATA/postgresql.conf

pg_ctl -D $PGDATA -l var/log/postgresql/postgres.log -w start

if [ "$PG_DB" != 'postgres' ]; then
  if psql -lqt | cut -d \| -f 1 | grep -qw $PG_DB; then
    echo "Database already exist !!!"
  else
    createSql="CREATE DATABASE $PG_DB ENCODING $PG_ENCODING"
    echo $createSql | psql postgres
    echo
  fi
fi

if [ "$PG_USER" != 'postgres' ]; then
  op=CREATE
else
  op=ALTER
fi

userSql="$op USER $PG_USER WITH SUPERUSER PASSWORD '$PG_PASSWORD'; \
  GRANT ALL PRIVILEGES ON DATABASE $PG_DB TO $PG_USER;"
echo $userSql | psql postgres

echo
for f in $INITDB/*; do
    case "$f" in
        *.sh)  echo "$0: running $f"; . "$f" ;;
        *.sql) echo "$0: running $f"; psql --username "$PG_USER" --dbname "$PG_DB" < "$f" && echo ;;
        *.sql.gz) echo "$0: running $f"; gunzip -c "$f" | psql --username "$PG_USER" --dbname "$PG_DB" < "$f" && echo ;;
        *)     echo "$0: ignoring $f" ;;
    esac
    echo
done
pg_ctl -D $PGDATA -m fast -w stop

echo 'PostgreSQL init process complete; ready for start up.'

postgres -D $PGDATA
