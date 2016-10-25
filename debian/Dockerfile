FROM debian:8
MAINTAINER Firdaws Aboulaye "aboufred@gmail.com"

ENV PG_VERSION 9.6
ENV PG_USER postgres_user
ENV PG_PASSWORD postgres_pwd
ENV PG_DB postgres_db
ENV PG_ENCODING UTF8
ENV PG_HOME /usr/lib/postgresql/$PG_VERSION
ENV PGDATA /var/lib/postgresql/data
ENV PATH $PG_HOME/bin:$PATH
ENV INITDB /docker-entrypoint-initdb.d

COPY docker-entrypoint.sh /

RUN apt-get update \
  && groupadd -r postgres --gid=1000 \
  && useradd -r -g postgres --uid=1000 postgres \
  && DEBIAN_FRONTEND=noninteractive \
  && apt-get install -y wget apt-utils \
  && echo "deb http://apt.postgresql.org/pub/repos/apt/ xenial-pgdg main" >> /etc/apt/sources.list.d/postgresql.list \
  && wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - \
  && apt-get update \
  && apt-get install -y postgresql-$PG_VERSION \
  && mkdir -p $PGDATA \
  && chmod 700 "$PGDATA" \
  && chown -R postgres "$PGDATA" \
  && chmod +x docker-entrypoint.sh \
  && apt-get clean \
  && rm -rf /tmp/* /usr/share/man/?? /usr/share/man/??_* /var/lib/apt/lists/*

USER postgres
VOLUME	$PGDATA
EXPOSE 5432
ENTRYPOINT ["/docker-entrypoint.sh"]
