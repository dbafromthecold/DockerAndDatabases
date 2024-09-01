#!/bin/bash

# Append the configuration line to pg_hba.conf
echo "host replication replicator 172.18.0.1/24 trust" >> /var/lib/postgresql/data/pg_hba.conf
