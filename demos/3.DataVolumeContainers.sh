############################################################################
############################################################################
#
# Docker & Databases - Andrew Pruski
# @dbafromthecold
# dbafromthecold@gmail.com
# https://github.com/dbafromthecold/DockerAndDatabases
# Data Volume Containers
#
############################################################################
############################################################################



# confirm no containers running
docker container ls -a



# confirm container images
docker image ls



# create the data volume container
docker container create -v /postgres-data --name datastore ubuntu



# confirm container
docker container ls -a



# confirm volume
docker volume ls



# run a container referencing the data volume container
docker run -d \
--name postgres1 \
--publish 15789:5432 \
--env POSTGRES_PASSWORD=Testing1122 \
--volumes-from datastore \
--volume /postgres-data:/var/lib/postgresql/data \
postgres



# set environmant variable for password
export PGPASSWORD='Testing1122'



# confirm version of postgres in container
psql -h localhost -p 15789 -U postgres -d postgres -V



# create a database
psql -h localhost -p 15789 -U postgres -d postgres -c "CREATE DATABASE testdatabase"



# confirm database has been created
psql -h localhost -p 15789 -U postgres -d postgres -l



# stop and remove the container
docker container rm postgres1 -f



# confirm no containers running
docker container ls -a



# run another container referencing the data volume container again
docker run -d \
--name postgres2 \
--publish 15790:5432 \
--env POSTGRES_PASSWORD=Testing1122 \
--volumes-from datastore \
--volume /postgres-data:/var/lib/postgresql/data \
postgres



# confirm custom database is still there
psql -h localhost -p 15790 -U postgres -d postgres -l



# clean up
docker container rm postgres2 -f