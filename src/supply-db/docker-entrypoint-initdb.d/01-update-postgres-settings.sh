#!/bin/sh

echo "Running $0"

sed -i 's/^#wal_level.*/wal_level = logical/g' $PGDATA/postgresql.conf
sed -i 's/^#max_replication_slots=.*/max_replication_slots = 10/g' $PGDATA/postgresql.conf
sed -i 's/^#max_replication_slots =.*/max_replication_slots = 10/g' $PGDATA/postgresql.conf
sed -i 's/^#max_wal_senders =.*/max_wal_senders = 10/g' $PGDATA/postgresql.conf
sed -i 's/^#wal_sender_timeout =.*/wal_sender_timeout = 0/g' $PGDATA/postgresql.conf


cat  $PGDATA/postgresql.conf | grep 'wal_level'
cat  $PGDATA/postgresql.conf | grep 'max_replication_slots'
cat  $PGDATA/postgresql.conf | grep 'max_wal_senders'
cat  $PGDATA/postgresql.conf | grep 'wal_sender_timeout'
cat  $PGDATA/postgresql.conf | grep 'idle_in_transaction_session_timeout'

REP_ENTRY="host replication all all md5"

if [ $(grep "$REP_ENTRY" $PGDATA/pg_hba.conf) ]; then
  echo "Replication entry already exists in pg_hba.conf"
else
  echo "$REP_ENTRY" >> $PGDATA/pg_hba.conf
  echo "Replication entry added to pg_hba.conf"
fi

