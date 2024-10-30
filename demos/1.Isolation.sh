############################################################################
############################################################################
#
# Docker & Databases - Andrew Pruski
# @dbafromthecold
# dbafromthecold@gmail.com
# https://github.com/dbafromthecold/DockerAndDatabases
# Container Isolation
#
############################################################################
############################################################################



# run a container - limiting the memory available to it
docker container run -d \
--name postgres1 \
--publish 15793:5432 \
--memory 2048M \
--env POSTGRES_PASSWORD=Testing1122 \
ghcr.io/dbafromthecold/custom-postgres:latest



# confirm container is running
docker container ls -a



# list containers again using --format
docker container ls -a --format "table {{.Names }}\t{{ .Image }}\t{{ .Status }}\t{{.Ports}}"



# grab the container ID
CONTAINERID=$(docker ps -aq) && echo $CONTAINERID



# view control groups created
find /sys/fs/cgroup/ -name *$CONTAINERID*



# get memory and cpu control groups
MEMORYCGROUP=$(find /sys/fs/cgroup/ -name *$CONTAINERID* | grep memory) && echo $MEMORYCGROUP
CPUCGROUP=$(find /sys/fs/cgroup/ -name *$CONTAINERID* | grep cpu,cpuacct) && echo $CPUCGROUP



# get memory limit
MEMORYLIMIT=$(cat $MEMORYCGROUP/memory.limit_in_bytes)



# show memory limit of container in MB
expr $MEMORYLIMIT / 1024 / 1024



# show unrestricted CPU limit
cat $CPUCGROUP/cpu.cfs_quota_us



# set CPU limit on the fly
docker update postgres1 --cpus 2



# show restricted CPU limit
cat $CPUCGROUP/cpu.cfs_quota_us



# view namespaces created
sudo lsns | grep postgres



# view hostname of Docker host
hostname



# view the hostname within the container
docker exec postgres1 hostname



# list processes within the container
docker exec postgres1 ps aux



# view postgres processes on host
ps aux | grep postgres



# grab the pid
pid=$(sudo lsns | grep postgres | awk '!visited[$4]++ {print $4}') && echo $pid



# enter the namespaces
sudo nsenter -t $pid --pid --uts --mount --net --ipc /bin/bash



# check the hostname
hostname



# check the processes running
ps aux



# exit namespaces
exit



# set environmant variable for password to connect to postgres
export PGPASSWORD='Testing1122'



# create a database in the SQL instance in the container
psql -h localhost -p 15793 -U postgres -d postgres -c "CREATE DATABASE testdatabase"



# confirm database has been created
psql -h localhost -p 15793 -U postgres -d postgres -l



# list the database files within the container
docker exec postgres1 ls -al /var/lib/postgresql/data/base



# get container's volume location on host
FILES=$(docker inspect postgres1 --format '{{ (index .Mounts 0).Source }}' ) && echo $FILES



# view view contents of the volume on the host
sudo ls -al $FILES/base



# clean up
docker rm $(docker ps -aq) -vf
