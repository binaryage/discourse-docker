#!/bin/bash
# forked from https://gist.github.com/jpetazzo/5494158


DATADIR=/var/lib/postgresql/9.1/main
BINDIR=/usr/lib/postgresql/9.1/bin

# test if DATADIR is existent
if [ ! -d $DATADIR ]; then
  echo "Creating Postgres data at $DATADIR"
  mkdir -p $DATADIR
fi

echo 'host all all 0.0.0.0/0 md5' >> /etc/postgresql/9.1/main/pg_hba.conf

# test if DATADIR has content
if [ ! "$(ls -A $DATADIR)" ]; then
  echo "Initializing Postgres Database at $DATADIR"
  chown -R postgres $DATADIR
  su postgres sh -c "$BINDIR/initdb $DATADIR"
  su postgres sh -c "$BINDIR/postgres --single  -D $DATADIR  -c config_file=/etc/postgresql/9.1/main/postgresql.conf" <<< "CREATE USER root WITH SUPERUSER PASSWORD '$PASS';"
fi

cat /etc/postgresql/9.1/main/postgresql.conf

su postgres sh -c "$BINDIR/postgres           -D $DATADIR  -c config_file=/etc/postgresql/9.1/main/postgresql.conf  -c listen_addresses=*" 
