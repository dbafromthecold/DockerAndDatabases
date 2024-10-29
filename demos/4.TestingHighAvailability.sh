############################################################################
############################################################################
#
# Docker & Databases - Andrew Pruski
# @dbafromthecold
# dbafromthecold@gmail.com
# https://github.com/dbafromthecold/DockerAndDatabases
# https://www.postgresql.org/docs/current/warm-standby.html
# https://github.com/MichaelCade/90DaysOfDevOps/blob/main/2023/day66.md 
# Testing HA for PostgreSQL in containers
#
############################################################################
############################################################################



# create custom bridge network
docker network create --subnet=172.21.0.0/16  postgres



# run a container with named volumes
docker run -d \
--publish 5432:5432 \
--network=postgres \
--volume postgres-data:/var/lib/postgresql/data \
--volume postgres-base:/postgres/archive/base \
--env POSTGRES_PASSWORD=Testing1122 \
--env POSTGRES_DB=testdatabase \
--name postgres1 \
postgres:17



# confirm volumes
docker volume ls



# set environmant variable for password
export PGPASSWORD='Testing1122'



# confirm database has been created
psql -h localhost -p 5432 -U postgres -d postgres -l



# inspect network to confirm IP address of container
docker network inspect postgres



# update pg_hba.conf to allow connections to the secondary instance (using IP range for the docker containers on this host)
docker exec -u postgres postgres1 bash -c 'echo "host replication replicator 172.21.0.3/16 trust" >> /var/lib/postgresql/data/pg_hba.conf'



# create a user for replication
psql -h localhost -p 5432 -U postgres -d postgres -c "CREATE USER replicator WITH REPLICATION ENCRYPTED PASSWORD 'Testing1122';"



# create replication slot
psql -h localhost -p 5432 -U postgres -d postgres -c "SELECT * FROM pg_create_physical_replication_slot('replication_slot_slave1');"



# confirm replication slot has been created
psql -h localhost -p 5432 -U postgres -d postgres -c "SELECT slot_name, slot_type, active FROM pg_replication_slots;"



# take a base backup
docker exec postgres1 bash -c 'pg_basebackup -D /postgres/archive/base -S replication_slot_slave1 -X stream -U replicator -Fp -R'



# run a second container, mapping the named volume to the postgres data directory
docker run -d \
--publish 5433:5432 \
--network=postgres \
--volume postgres-base:/var/lib/postgresql/data \
--env POSTGRES_PASSWORD=Testing1122 \
--name postgres2 \
postgres:17



# confirm volumes
docker volume ls



# confirm database in second container
psql -h localhost -p 5433 -U postgres -d postgres -l



# update the postgresql.auto.conf with information about the primary container
docker exec -u postgres postgres2 bash -c "echo \"primary_conninfo = 'host=postgres1 port=5432 user=replicator password=Testing1122'\" >> \$PGDATA/postgresql.auto.conf"



# restart both containers
docker container restart postgres1 postgres2



# connect to the database in the container, create a table, and then insert some data
psql -h localhost -p 5432 -U postgres -d testdatabase -c "CREATE TABLE test_table (
  id smallint,
  first_name VARCHAR(50),
  last_name VARCHAR(50),
  dob DATE,
  email VARCHAR(255),
  CONSTRAINT test_table_pkey PRIMARY KEY (id)
);

INSERT INTO test_table (id, first_name, last_name, dob, email)
VALUES 
(1, 'Andrew', 'Pruski', '1983-08-13', 'dbafromthecold@gmail.com'),
(2, 'Ursula', 'McPruski', '1985-05-06', 'mcpruski@yahoo.ie');"



# confirm data has been replicated over to the secondary instance
psql -h localhost -p 5433 -U postgres -d testdatabase -c "SELECT * FROM test_table"



# clean up
docker container rm postgres1 postgres2 -f
docker volume rm postgres-data postgres-base
docker network rm postgres