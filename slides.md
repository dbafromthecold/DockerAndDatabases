# Docker & Databases

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
To provide an overview to persisting data for databases in Docker

---

## Options for persisting data
<!-- .slide: style="text-align: left;"> -->
- Bind mounts<br>
- Named volumes<br>
- Data volume containers

---

## Bind Mounts
<!-- .slide: style="text-align: left;"> -->
- Mounting directories from the host
- Use absolute path
- Can be created on demand
- Adding dependency to container

---

# Demo

---

## Named Volumes
<!-- .slide: style="text-align: left;"> -->
- Volume(s) created/managed by Docker
- No dependency on the host
- Lifecycle outside any container referencing it
- Higher performance than bind mounts

---

# Demo

---

## Data Volume Containers
<!-- .slide: style="text-align: left;"> -->
- Container created with volumes
- Not in the running state
- Volumes created in background
- Other containers reference data volume container
- Useful for mapping a large amount of volumes

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
