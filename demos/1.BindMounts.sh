############################################################################
############################################################################
#
# Docker & Databases - Andrew Pruski
# @dbafromthecold
# dbafromthecold@gmail.com
# https://github.com/dbafromthecold/DockerAndDatabases
# Bind Mounts
#
############################################################################
############################################################################



# remove existing directory (if exists)
sudo rm -rfv /home/apruski/postgres-local



# create new directory
mkdir /home/apruski/postgres-local



# confirm no containers running
docker container ls -a



# confirm container images
docker image ls | grep postgres



# run a container with a bind mount
docker container run -d \
--name postgres1 \
--publish 15789:5432 \
--env POSTGRES_PASSWORD=Testing1122 \
--volume /home/apruski/postgres-local:/var/lib/postgresql/data \
postgres:latest



# confirm container running
docker container ls -a



# inspect the container
# https://docs.docker.com/engine/storage/bind-mounts/#configure-bind-propagation
# rprivate - no mount points anywhere within the original or replica mount points propagate in either direction
docker container inspect postgres1 | jq '.[0].Mounts'



# set environmant variable for password
export PGPASSWORD='Testing1122'



# confirm version of postgres in container
psql -h localhost -p 15789 -U postgres -d postgres -c "SELECT version();"



# create a database
psql -h localhost -p 15789 -U postgres -d postgres -c "CREATE DATABASE testdatabase"



# confirm database has been created
psql -h localhost -p 15789 -U postgres -d postgres -l



# view the contents of the bind mount
sudo ls /home/apruski/postgres-local/



# stop and remove the container
docker container rm postgres1 -f



# confirm no containers running
docker container ls -a



# run another container with the same bind mount    
docker container run -d \
--name postgres2 \
--publish 15790:5432 \
--env POSTGRES_PASSWORD=Testing1122 \
--mount type=bind,source=/home/apruski/postgres-local,target=/var/lib/postgresql/data \
postgres:latest



# confirm custom database is still there
psql -h localhost -p 15790 -U postgres -d postgres -l



# remove directory
sudo rm -rfv /home/apruski/postgres-local



# confirm container running
docker container ls -a



# view container logs
docker container logs postgres2



# clean up
docker container rm postgres2 -f
sudo rm -rfv /home/apruski/postgres-local