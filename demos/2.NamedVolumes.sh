############################################################################
############################################################################
#
# Docker & Databases - Andrew Pruski
# @dbafromthecold
# dbafromthecold@gmail.com
# https://github.com/dbafromthecold/DockerAndDatabases
# Named Volumes
#
############################################################################
############################################################################



# confirm no containers running
docker container ls -a



# create a named volume
docker volume create postgres-data



# confirm volume
docker volume ls



# run a container with a named volume
docker container run -d \
--name postgres3 \
--publish 15791:5432 \
--env POSTGRES_PASSWORD=Testing1122 \
--volume postgres-data:/var/lib/postgresql/data \
postgres:latest



# confirm container is running
docker container ls -a



# inspect the container
# https://docs.docker.com/engine/storage/bind-mounts/#configure-bind-propagation
docker container inspect postgres3  | jq '.[0].Mounts'



# set environmant variable for password
export PGPASSWORD='Testing1122'



# confirm connection to postgres
psql -h localhost -p 15791 -U postgres -d postgres -c "SELECT version();"



# create a database
psql -h localhost -p 15791 -U postgres -d postgres -c "CREATE DATABASE testdatabase2"



# confirm database has been created
psql -h localhost -p 15791 -U postgres -d postgres -l



# stop and remove the container
docker container rm postgres3 -f



# confirm no containers running
docker container ls -a



# create volume still exists
docker volume ls



# run another container with the same named volume
docker container run -d \
--name postgres4 \
--publish 15792:5432 \
--env POSTGRES_PASSWORD=Testing1122 \
--mount type=volume,src=postgres-data,dst=/var/lib/postgresql/data,volume-driver=local \
postgres



# confirm custom database is still there
psql -h localhost -p 15792 -U postgres -d postgres -l



# clean up
docker container rm postgres4 -f
docker volume rm postgres-data