############################################################################
############################################################################
#
# Docker & Databases - Andrew Pruski
# @dbafromthecold
# dbafromthecold@gmail.com
# https://github.com/dbafromthecold/DockerAndDatabases
# Persisting data with Named Volumes
#
############################################################################
############################################################################



# remove all previous volumes
docker volume prune -f



# confirm no containers running
docker container ls -a



# create a named volume
docker volume create postgres-data



# confirm volume
docker volume ls



# run a container with a named volume
docker container run -d \
--name postgres1 \
--publish 15791:5432 \
--env POSTGRES_PASSWORD=Testing1122 \
--volume postgres-data:/var/lib/postgresql/data \
postgres:17



# confirm container is running
docker container ls -a



# inspect the container
docker container inspect postgres1  | jq '.[0].Mounts'
# mode z - SELinux labels on the volume to allow shared access across containers



# set environmant variable for password
export PGPASSWORD='Testing1122'



# confirm connection to postgres
psql -h localhost -p 15791 -U postgres -d postgres -c "SELECT version();"



# create a database
psql -h localhost -p 15791 -U postgres -d postgres -c "CREATE DATABASE testdatabase"



# confirm database has been created
psql -h localhost -p 15791 -U postgres -d postgres -l



# stop and remove the container
docker container rm postgres1 -f



# confirm no containers running
docker container ls -a



# create volume still exists
docker volume ls



# run another container with the same named volume
docker container run -d \
--name postgres2 \
--publish 15792:5432 \
--env POSTGRES_PASSWORD=Testing1122 \
--mount type=volume,src=postgres-data,dst=/var/lib/postgresql/data,volume-driver=local \
postgres:17



# confirm custom database is still there
psql -h localhost -p 15792 -U postgres -d postgres -l



# clean up
docker container rm postgres2 -f
docker volume rm postgres-data