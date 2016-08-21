# Postgres [![Build Status](https://travis-ci.org/faboulaye/docker-postgres.svg?branch=master)](https://travis-ci.org/faboulaye/docker-postgres)

* Postgres with debian : [postgres/debian](https://github.com/faboulaye/docker-postgres/blob/master/full/Dockerfile) [![](https://images.microbadger.com/badges/image/faboulaye/postgres.svg)](https://microbadger.com/images/faboulaye/postgres "Get your own image badge on microbadger.com")

```docker run -itP --rm --name postgres -v /Your/postgres/data/folder:/var/lib/postgresql/data faboulaye/postgres```

* postgres with alpine : [postgres/alpine](https://github.com/faboulaye/docker-postgres/blob/master/min/Dockerfile) [![](https://images.microbadger.com/badges/image/faboulaye/postgres:slim.svg)](http://microbadger.com/images/faboulaye/postgres:slim "Get your own image badge on microbadger.com")

```docker run -itP --rm --name postgres -v /Your/postgres/data/folder:/var/lib/postgresql/data faboulaye/postgres:slim```
