############################################################################
############################################################################
#
# Docker & Databases - Andrew Pruski
# @dbafromthecold
# dbafromthecold@gmail.com
# https://github.com/dbafromthecold/DockerAndDatabases
# Container Networking
#
############################################################################
############################################################################



# list networks
docker network ls



# inspect the default bridge network
docker network inspect bridge



# let's run two sql containers on the default bridge network
docker container run -d \
--name postgres1 \
--memory 2048M \
--env POSTGRES_PASSWORD=Testing1122 \
ghcr.io/dbafromthecold/custom-postgres:latest

docker container run -d \
--name postgres2 \
--memory 2048M \
--env POSTGRES_PASSWORD=Testing1122 \
ghcr.io/dbafromthecold/custom-postgres:latest



# confirm containers are running
docker container ls -a --format "table {{.Names }}\t{{ .Image }}\t{{ .Status }}\t{{.Ports}}"



# inspect the default bridge network
docker network inspect bridge



# grab the IP addresses of the containers
IPADDR1=$(docker inspect postgres1 --format '{{ .NetworkSettings.IPAddress }}') && echo $IPADDR1
IPADDR2=$(docker inspect postgres2 --format '{{ .NetworkSettings.IPAddress }}') && echo $IPADDR2 



# ping one of the containers using the container name
docker exec postgres1 ping postgres2 -c 4



# ping one of the containers using the ip address
docker exec postgres1 ping $IPADDR2 -c 4



# set environmant variable for password to connect to postgres
export PGPASSWORD='Testing1122'



# now connect to SQL in a container from the host
psql -h $IPADDR1 -U postgres -d postgres -c "SELECT version();"



# let's blow the containers away
docker rm $(docker ps -aq) -f



# and spin them up again, this time adding entries for each in the hosts file
docker container run -d \
--name postgres1 \
--memory 2048M \
--env POSTGRES_PASSWORD=Testing1122 \
--add-host=postgres2:172.17.0.3 \
ghcr.io/dbafromthecold/custom-postgres:latest

docker container run -d \
--name postgres2 \
--memory 2048M \
--env POSTGRES_PASSWORD=Testing1122 \
--add-host=postgres1:172.17.0.2 \
ghcr.io/dbafromthecold/custom-postgres:latest



# ping one of the containers using the container name
docker exec postgres1 ping postgres2 -c 4



# let's run two more containers on the default bridge network with ports mapped
docker container run -d \
--name postgres3 \
--publish 15789:5432 \
--memory 2048M \
--env POSTGRES_PASSWORD=Testing1122 \
ghcr.io/dbafromthecold/custom-postgres:latest

docker container run -d \
--name postgres4 \
--publish 15799:5432 \
--memory 2048M \
--env POSTGRES_PASSWORD=Testing1122 \
ghcr.io/dbafromthecold/custom-postgres:latest



# view port mapping
docker port postgres3
docker port postgres4



# now connect to SQL in a container from the host
psql -h localhost -p 15789 -U postgres -d postgres -c "SELECT version();"



# remove the containers
docker rm $(docker ps -aq) -f



# create custom bridge network
docker network create postgres



# list networks
docker network ls



# create two new containers on the custom network
docker container run -d \
--network=postgres \
--name postgres5 \
--publish 15800:5432 \
--memory 2048M \
--env POSTGRES_PASSWORD=Testing1122 \
ghcr.io/dbafromthecold/custom-postgres:latest

docker container run -d \
--network=postgres \
--name postgres6 \
--publish 15810:5432 \
--memory 2048M \
--env POSTGRES_PASSWORD=Testing1122 \
ghcr.io/dbafromthecold/custom-postgres:latest



# ping containers by name
docker exec postgres5 ping postgres6 -c 4



# view dns settings
docker exec postgres5 cat /etc/resolv.conf



# clean up
docker rm $(docker ps -aq) -f
docker network rm postgres