#!/bin/bash


# update the postgresql.auto.conf with information about the primary container
echo "primary_conninfo = 'host=postgres1 port=5432 user=replicator password=Testing1122'" >> "/var/lib/postgresql/data/postgresql.auto.conf"