FROM alpine:edge
MAINTAINER Firdaws Aboulaye "aboufred@gmail.com"

# Initial default user/pass and schema
ENV PG_USER postgres_user
ENV PG_PASSWORD postgres_pwd
ENV PG_DB postgres_db
ENV PG_ENCODING SQL_ASCII
ENV LANG en_US.utf8
ENV PGDATA /var/lib/postgresql/data
ENV INITDB /docker-entrypoint-initdb.d

COPY docker-entrypoint.sh /

RUN echo "@edge http://nl.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories \
  && apk add --update postgresql \
  && mkdir -p $INITDB $PGDATA \
  && chmod +x docker-entrypoint.sh \
  && chown -R postgres:postgres "$PGDATA" \
  && rm -rf /var/cache/apk/*

USER postgres
VOLUME $PGDATA
EXPOSE 5432
ENTRYPOINT ["/docker-entrypoint.sh"]
