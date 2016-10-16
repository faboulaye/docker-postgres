# Postgres [![Build Status](https://travis-ci.org/faboulaye/docker-postgres.svg?branch=master)](https://travis-ci.org/faboulaye/docker-postgres)

* Postgres with debian : [postgres/debian](https://github.com/faboulaye/docker-postgres/blob/master/debianl/Dockerfile) [![](https://images.microbadger.com/badges/image/faboulaye/postgres.svg)](https://microbadger.com/images/faboulaye/postgres "Get your own image badge on microbadger.com")

```docker run -it --rm --name postgres -v /Your/postgres/data/folder:/var/lib/postgresql/data faboulaye/postgres```

* postgres with alpine : [postgres/alpine](https://github.com/faboulaye/docker-postgres/blob/master/alpine/Dockerfile) [![](https://images.microbadger.com/badges/image/faboulaye/postgres:alpine.svg)](http://microbadger.com/images/faboulaye/postgres:alpine "Get your own image badge on microbadger.com")

```docker run -it --rm --name postgres -v /Your/postgres/data/folder:/var/lib/postgresql/data faboulaye/postgres:alpine```
