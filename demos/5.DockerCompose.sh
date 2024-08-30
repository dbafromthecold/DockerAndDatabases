############################################################################
############################################################################
#
# Docker & Databases - Andrew Pruski
# @dbafromthecold
# dbafromthecold@gmail.com
# https://github.com/dbafromthecold/DockerAndDatabases
# Docker Compose
#
############################################################################
############################################################################



# navigate to code
cd /mnt/c/git/DockerAndDatabases/demos/compose



# have a look at the docker-compose file
cat docker-compose.yaml && echo ""



# check the docker networks on the host
docker network ls



# check the volumes on the host
docker volume ls



# spin up a container with docker compose
docker-compose up -d



# recheck the docker networks on the host
docker network ls



# recheck the named volumes
docker volume ls



# check the containers running
docker container ls -a



# confirm status of postgres in both containers
docker logs postgres1
docker logs postgres2



# set environmant variable for password
export PGPASSWORD='Testing1122'



# confirm database in first container
psql -h localhost -p 5432 -U postgres -d postgres -l



# confirm database in second container
psql -h localhost -p 5433 -U postgres -d postgres -l



# confirm secondary is in standby mode
psql -h localhost -p 5433 -U postgres -d testdatabase -c "SELECT pg_is_in_recovery();"



# connect to the testdatabase database in the first container, create a table, and then insert some data
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



# confirm data has been replicated over to the secondary container
psql -h localhost -p 5433 -U postgres -d testdatabase -c "SELECT * FROM test_table"



# clean up
docker-compose down -v