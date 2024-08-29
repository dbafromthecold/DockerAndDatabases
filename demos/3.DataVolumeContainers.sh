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



# confirm no volumes
docker volume ls



# create the data volume container
docker container create \
--mount type=volume,dst=/var/lib/postgresql/data,volume-driver=local \
--name datastore \
ubuntu


# confirm running containers
docker container ls



# confirm container
docker container ls -a



# confirm anonymous volume
docker volume ls



# run a container referencing the data volume container
docker container run -d \
--name postgres5 \
--publish 15793:5432 \
--env POSTGRES_PASSWORD=Testing1122 \
--volumes-from datastore \
postgres



# set environmant variable for password
export PGPASSWORD='Testing1122'



# confirm connection to postgres
psql -h localhost -p 15793 -U postgres -d postgres -c "SELECT version();"



# create a database
psql -h localhost -p 15793 -U postgres -d postgres -c "CREATE DATABASE testdatabase3"



# confirm database has been created
psql -h localhost -p 15793 -U postgres -d postgres -l



# stop and remove the container
docker container rm postgres5 -f



# confirm no containers running
docker container ls



# confirm data volume container
docker container ls -a



# confirm volume
docker volume ls



# run another container referencing the data volume container again
docker run -d \
--name postgres6 \
--publish 15794:5432 \
--env POSTGRES_PASSWORD=Testing1122 \
--volumes-from datastore \
postgres



# confirm custom database is still there
psql -h localhost -p 15794 -U postgres -d postgres -l



# clean up
docker container rm postgres6 datastore -f
docker volume rm $(docker volume ls -q)