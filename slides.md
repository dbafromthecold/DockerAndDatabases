# Diving into Docker

---

## Andrew Pruski

<img src="images/apruski.jpg" style="float: right"/>

### Field Solutions Architect
#### Microsoft Data Platform MVP
#### Docker Captain
#### VMware vExpert

<!-- .slide: style="text-align: left;"> -->
<i class="fab fa-twitter"></i><a href="https://twitter.com/dbafromthecold">  @dbafromthecold</a><br>
<i class="fas fa-envelope"></i>  dbafromthecold@gmail.com<br>
<i class="fab fa-wordpress"></i>  www.dbafromthecold.com<br>
<i class="fab fa-github"></i><a href="https://github.com/dbafromthecold">  github.com/dbafromthecold</a>

---

## Session Aim
<!-- .slide: style="text-align: left;"> -->
To provide a deeper knowledge of the Docker platform - UPDATE!

---

## Why databases in Docker?

<img src="images/docker_icon.png" style="float: right"/>

<!-- .slide: style="text-align: left;"> -->
- Ease of deployment
- Known configuration
- Testing new versions (rollback)
- Separate compute from data

---

## Agenda
<!-- .slide: style="text-align: left;"> -->
- Isolation<br>
- Networking<br>
- Persisting data<br>
- Custom images<br>
- Docker Compose<br>

---

# Isolation

---

## Container Isolation
<!-- .slide: style="text-align: left;"> -->
"Containers isolate software from its environment and ensure that it works uniformly despite differences for instance between development and staging"<br>
<font size="6"><a href="https://www.docker.com/resources/what-container">docker.com/resources/what-container</a></font>

---

## Control Groups
<!-- .slide: style="text-align: left;"> -->
Ensures a single container cannot consume all<br>
resources of the host<br>
<br>
Implements resource limiting of:-
- CPU
- Memory

---

## Namespaces
<!-- .slide: style="text-align: left;"> -->
Control what a container can see<br>
<br>
Used to control:-<br>
- Hostname within the container
- Processes that the container can see
- Mapping users in the container to users on the host

---

## File system
<!-- .slide: style="text-align: left;"> -->
- Containers cannot see the entire host's filesystem<br>
- They can only see a subset of that filesystem<br>
- The container root directory is changed

---

# Demo

---

# Networking

---

## Default networks
<!-- .slide: style="text-align: left;"> -->
<img src="images/docker_default_networks.png" style="float: right"/>

- bridge<br>
- host<br>
- none<br>

---

## Bridge network
<!-- .slide: style="text-align: left;"> -->
- Default network<br>
- Represents _docker0_ network<br>
- Containers communicate by IP address<br>
- Supports port mapping 

---

## User defined networks
<!-- .slide: style="text-align: left;"> -->
- Docker provide multiple drivers<br>
- DNS resolution of container names to IP addresses<br>
- Can be connected to more than one network<br>
- Connect/disconnect from networks without restarting<br>

---

# Demo

---

# Persisting data

---

## Options for persisting data
<!-- .slide: style="text-align: left;"> -->
- Bind mounts<br>
- Data volume containers<br>
- Named volumes


---

# Demo

---

## Resources
<!-- .slide: style="text-align: left;"> -->
<font size="6">
<a href="https://github.com/dbafromthecold/DockerAndDatabases">https://github.com/dbafromthecold/DockerAndDatabases</a><br>
</font>

<p align="center">
  <img src="images/DockerDatabasesQr.png" />
</p>
