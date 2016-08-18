FROM alpine:3.4
MAINTAINER Firdaws Aboulaye "aboufred@gmail.com"

# Initial default user/pass and schema
ENV PG_USER postgres_user
ENV PG_PASSWORD postgres_pwd
ENV PG_DB_NAME postgres_db
ENV PG_ENCODING SQL_ASCII
ENV LANG en_US.utf8
ENV PG_DATA /var/lib/postgresql/data

COPY docker-entrypoint.sh /

RUN echo "@edge http://nl.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories \
  && apk update \
  && apk add curl "postgresql@edge<9.6" "postgresql-contrib@edge<9.6" \
  && mkdir /docker-entrypoint-initdb.d \
  && curl -o /usr/local/bin/gosu -sSL "https://github.com/tianon/gosu/releases/download/1.9/gosu-amd64" \
  && chmod +x /usr/local/bin/gosu /docker-entrypoint.sh \
  && apk del curl \
  && rm -rf /var/cache/apk/*

VOLUME /var/lib/postgresql/data

EXPOSE 5432

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["postgres"]
