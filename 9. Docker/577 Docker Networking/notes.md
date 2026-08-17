# Docker Networking Notes

## 1. What is Docker Networking?

Docker networking allows containers to **communicate with each other, the host, and external networks**.

Example:

```text
                Docker Host
                     |
             Docker Network
              /           \
        Backend          Database
        Container        Container
```

Networking is important when applications have multiple containers.

Example:

```text
Frontend → Backend → Database
```

---

## 2. Why Do We Need Docker Networking?

Suppose we have:

```text
Backend Container
       |
       v
PostgreSQL Container
```

The backend needs a way to communicate with PostgreSQL.

Docker networking provides:

- Container-to-container communication
- Network isolation
- DNS-based service discovery
- External access through port mapping

---

## 3. Docker Network Types

| Network | Purpose |
|---|---|
| Bridge | Default network for containers |
| Host | Container shares host's network |
| None | No network connectivity |
| Overlay | Networking across Docker Swarm nodes |

For normal Docker applications, **bridge networks** are the most commonly used.

---

## 4. Bridge Network

Docker creates a default bridge network.

Check networks:

```bash
docker network ls
```

Example:

```text
NETWORK ID     NAME      DRIVER
xxxx           bridge    bridge
```

A custom bridge network can also be created:

```bash
docker network create my-network
```

---

## 5. Container Communication

Create a network:

```bash
docker network create app-network
```

Run a Redis container:

```bash
docker run -d \
  --name redis \
  --network app-network \
  redis:alpine
```

Run another container on the same network:

```bash
docker run -it \
  --name app \
  --network app-network \
  alpine sh
```

Containers on the same user-defined network can communicate using container names.

```text
app container
     |
     | redis:6379
     v
redis container
```

The hostname is:

```text
redis
```

You normally do not need to find the Redis container's IP address.

---

## 6. Port Mapping

Port mapping makes a container service accessible through the Docker host.

Example:

```bash
docker run -d -p 8080:80 nginx
```

Meaning:

```text
Host Port 8080
       |
       v
Container Port 80
       |
       v
     Nginx
```

Format:

```text
-p HOST_PORT:CONTAINER_PORT
```

Important:

`EXPOSE 80` in a Dockerfile does **not** publish the port.

You need `-p` when you want to publish the container port to the host.

---

## 7. Inspect a Network

```bash
docker network inspect app-network
```

This shows information such as:

- Connected containers
- Network configuration
- IP addresses
- Gateway

---

## 8. Practical

### Objective

Create a custom network and run two containers on it.

### Step 1: Create Network

```bash
docker network create app-network
```

### Step 2: Run Redis

```bash
docker run -d \
  --name redis \
  --network app-network \
  redis:alpine
```

### Step 3: Run Alpine Container

```bash
docker run -it \
  --name client \
  --network app-network \
  alpine sh
```

### Step 4: Test Communication

Inside the Alpine container:

```bash
ping redis
```

The hostname `redis` is resolved through Docker's network DNS.

You can also inspect the network:

```bash
docker network inspect app-network
```

### Step 5: Clean Up

Exit:

```bash
exit
```

Remove containers:

```bash
docker rm -f client redis
```

Remove network:

```bash
docker network rm app-network
```

**Screenshot:** Add a screenshot of `docker network ls`, successful container communication, and `docker network inspect`.

---

## 9. Docker Compose Networking

Docker Compose automatically creates a network for services.

Example:

```yaml
services:

  backend:
    image: my-backend

  db:
    image: postgres:16
```

The backend can connect to PostgreSQL using:

```text
db:5432
```

Not:

```text
localhost:5432
```

Inside the backend container, `localhost` means **the backend container itself**, not the database container.

This is a very important concept.

---

## 10. Best Practices

- Use custom bridge networks for multi-container applications.
- Use service/container names for communication instead of hardcoded IP addresses.
- Publish only the ports that need external access.
- Keep internal services on private Docker networks where possible.
- Don't expose databases directly to the internet.

---

## 11. Common Mistakes

### Using `localhost` Between Containers

Incorrect:

```text
backend → localhost:5432
```

Correct:

```text
backend → db:5432
```

### Confusing Host and Container Ports

```bash
-p 8080:80
```

means:

```text
Host:8080 → Container:80
```

It does not mean the application listens on port `8080` inside the container.

### Hardcoding Container IPs

Avoid:

```text
172.18.0.5
```

Use the container/service name:

```text
db
```

---

## 12. Interview Questions

1. What is Docker networking?
2. What is the default Docker network?
3. What is a bridge network?
4. How can two containers communicate?
5. What does `-p 8080:80` mean?
6. What is the difference between a host port and a container port?
7. Why should containers use service names instead of IP addresses?
8. Why doesn't `localhost` normally work for communication between containers?
9. What is an overlay network?

---

## 13. Summary

- Docker networking allows containers to communicate.
- **Bridge** is the most common network type for normal Docker applications.
- Custom networks provide better isolation and container communication.
- Containers on the same user-defined network can communicate using names.
- `-p HOST:CONTAINER` publishes a container port to the host.
- In multi-container applications:

```text
Backend → db:5432
```

is generally correct, while:

```text
Backend → localhost:5432
```

is not.