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
cd /mnt/c/git/DockerAndDatabases/demos/



# have a look at the docker-compose file
cat docker-compose.yaml && echo ""



# check the docker networks on the host
docker network ls



# check the named volumes on the host
docker volume ls



# spin up a container with docker compose
docker-compose up -d



# recheck the docker networks on the host
docker network ls



# recheck the named volumes
docker volume ls



# check the containers running
docker container ls -a



# set environmant variable for password
export PGPASSWORD='Testing1122'



# connect to the container
psql -h localhost -p 15795 -U postgres -d postgres -V



# create a database
psql -h localhost -p 15795 -U postgres -d postgres -c "CREATE DATABASE testdatabase4"



# confirm database has been created
psql -h localhost -p 15795 -U postgres -d postgres -l



# spin down the container
docker-compose down



# check the networks again
docker network ls



# check the containers
docker container ls -a



# check the volumes
docker volume ls



# clean up
docker volume rm demos_postgres_data