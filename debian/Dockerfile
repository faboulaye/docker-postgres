FROM debian:8
MAINTAINER Firdaws Aboulaye "aboufred@gmail.com"

ENV PG_VERSION 9.4
ENV PG_USER postgres_user
ENV PG_PASSWORD postgres_pwd
ENV PG_DB_NAME postgres_db
ENV PG_ENCODING SQL_ASCII
ENV PG_HOME /usr/lib/postgresql/$PG_VERSION
ENV PGDATA /var/lib/postgresql/$PG_VERSION/data
ENV PATH $PG_HOME/bin:$PATH

# Container infos
LABEL version = "1.0"
LABEL description = "PostgreSQL Server $PG_VERSION"

COPY docker-entrypoint.sh /
RUN apt-get update \
  && DEBIAN_FRONTEND=noninteractive \
  && apt-get install --no-install-recommends -y python-software-properties \
    software-properties-common postgresql-$PG_VERSION \
    postgresql-contrib-$PG_VERSION postgresql-client-$PG_VERSION \
  && chmod a+x docker-entrypoint.sh \
  && apt-get clean \
  && rm -rf /tmp/* /usr/share/man/?? /usr/share/man/??_* /var/lib/apt/lists/*

USER postgres
VOLUME	["/etc/postgresql", "/var/log/postgresql", "/var/lib/postgresql"]
EXPOSE 5432
# ENTRYPOINT ["/docker-entrypoint.sh"]
# CMD ["postgres"]
