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



# confirm no containers running
docker container ls -a



# confirm container images
docker image ls



# run a container with a bind mount
docker run -d \
--name postgres1 \
--publish 15789:5432 \
--env POSTGRES_PASSWORD=Testing1122 \
--volume ~/postgres-data:/var/lib/postgresql/data \
postgres



# set environmant variable for password
export PGPASSWORD='Testing1122'



# confirm version of postgres in container
psql -h localhost -p 15789 -U postgres -d postgres -V



# create a database
psql -h localhost -p 15789 -U postgres -d postgres -c "CREATE DATABASE testdatabase"


# confirm database has been created
psql -h localhost -p 15789 -U postgres -d postgres -l



# view the contents of the bind mount
sudo ls ~/postgres-data



# stop and remove the container
docker container rm postgres1 -f



# confirm no containers running
docker container ls -a



# run another container with the same bind mount    
docker run -d \
--name postgres2 \
--publish 15790:5432 \
--env POSTGRES_PASSWORD=Testing1122 \
--volume ~/postgres-data:/var/lib/postgresql/data \
postgres



# confirm custom database is still there
psql -h localhost -p 15790 -U postgres -d postgres -l



# clean up
docker container rm postgres2 -f