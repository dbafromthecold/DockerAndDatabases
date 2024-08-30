#!/bin/bash


# Set the password for the replicator user
export PGPASSWORD=Testing1122


# take a base backup
pg_basebackup -D /postgres/archive/base -S replication_slot_slave1 -X stream -U replicator -Fp -R


# Create a flag file to indicate that the base backup is complete
touch /postgres/archive/base/ready.flag


# Change the owner of the base backup directory to the postgres user
chmod 700 -R /postgres/archive/base


# Restart PostgreSQL to apply changes
/usr/lib/postgresql/16/bin/pg_ctl -D /var/lib/postgresql/data restart