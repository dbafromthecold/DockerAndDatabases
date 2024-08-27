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



# remove existing directory
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
postgres



# confirm container running
docker container ls -a



# set environmant variable for password
export PGPASSWORD='Testing1122'



# confirm version of postgres in container
psql -h localhost -p 15789 -U postgres -d postgres -V



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
--volume /home/apruski/postgres-local:/var/lib/postgresql/data \
postgres



# confirm custom database is still there
psql -h localhost -p 15790 -U postgres -d postgres -l



# clean up
docker container rm postgres2 -f
sudo rm -rfv /home/apruski/postgres-local