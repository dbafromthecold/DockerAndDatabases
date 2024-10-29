#!/bin/bash

# Append the configuration line to pg_hba.conf
echo "host replication replicator 172.25.0.3/24 trust" >> /var/lib/postgresql/data/pg_hba.conf
