# Docker Compose Notes

## 1. What is Docker Compose?

Docker Compose is a tool used to **define and run multiple Docker containers as one application**.

For example, a typical application may contain:

```text
          Docker Compose
                |
       +--------+--------+
       |                 |
    Backend            Database
   Container           Container
       |                 |
   Spring Boot        PostgreSQL
```

Instead of creating and configuring each container separately, we define everything in a `compose.yaml` file.

---

## 2. Why Use Docker Compose?

Docker Compose is useful when an application needs multiple services.

Example:

```text
Application
    |
    +--> Frontend
    +--> Backend
    +--> Database
    +--> Redis
```

Compose allows us to:

- Define multiple services in one file.
- Create containers with one command.
- Configure networks between services.
- Configure persistent volumes.
- Manage the complete application together.

---

## 3. `compose.yaml`

A basic example:

```yaml
services:

  web:
    image: nginx:alpine
    ports:
      - "8080:80"

  redis:
    image: redis:alpine
```

Here:

- `services` → Defines application services.
- `web` → Nginx service.
- `redis` → Redis service.
- `image` → Image used by the service.
- `ports` → Maps host port to container port.

---

## 4. Important Concepts

| Concept | Purpose |
|---|---|
| Service | Defines a container/application component |
| Image | Image used to create the container |
| Port | Exposes container port to the host |
| Volume | Provides persistent storage |
| Network | Allows containers to communicate |
| Environment | Provides configuration values |

---

## 5. Basic Commands

### Start Services

```bash
docker compose up
```

Run in background:

```bash
docker compose up -d
```

### Stop Services

```bash
docker compose down
```

### View Running Containers

```bash
docker compose ps
```

### View Logs

```bash
docker compose logs
```

Follow logs:

```bash
docker compose logs -f
```

### Rebuild Images

```bash
docker compose build
```

---

## 6. Practical Example

### Objective

Run Nginx and Redis using Docker Compose.

### Step 1: Create Directory

```bash
mkdir compose-demo
cd compose-demo
```

### Step 2: Create `compose.yaml`

```yaml
services:

  web:
    image: nginx:alpine
    ports:
      - "8080:80"

  redis:
    image: redis:alpine
```

### Step 3: Start Services

```bash
docker compose up -d
```

Expected:

```text
[+] Running 3/3
 ✔ Network compose-demo_default
 ✔ Container compose-demo-web-1
 ✔ Container compose-demo-redis-1
```

### Step 4: Verify

```bash
docker compose ps
```

Both services should show as running.

Open:

```text
http://localhost:8080
```

Nginx should display its default page.

**Screenshot:** Add a screenshot of `docker compose up -d`, `docker compose ps`, and the Nginx page.

### Step 5: Stop and Remove

```bash
docker compose down
```

This stops and removes the Compose containers and network.

---

## 7. Volumes

Containers are temporary by nature, so important data should be stored in volumes.

Example:

```yaml
services:
  db:
    image: postgres:16
    volumes:
      - db-data:/var/lib/postgresql/data

volumes:
  db-data:
```

```text
PostgreSQL Container
        |
        v
   db-data Volume
        |
        v
   Persistent Data
```

Even if the container is removed, the volume can preserve the database data.

---

## 8. Service Communication

Services in the same Compose application can communicate using their **service names**.

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

It does not normally need the container's IP address.

---

## 9. Environment Variables

Configuration can be provided using environment variables.

```yaml
services:
  backend:
    image: my-backend
    environment:
      DB_HOST: db
      DB_PORT: 5432
```

For sensitive information, avoid hardcoding secrets in the Compose file. Use appropriate secret-management mechanisms.

---

## 10. Common Mistakes

- Incorrect YAML indentation.
- Forgetting to run `docker compose up`.
- Confusing host ports with container ports.
- Storing database data without a volume.
- Using container IP addresses instead of service names.
- Putting passwords directly into Compose files.

---

## 11. Best Practices

- Keep one Compose file focused on one application/environment.
- Use named volumes for persistent data.
- Use service names for container-to-container communication.
- Keep secrets out of Git.
- Use environment variables for configurable values.
- Use `docker compose down` to cleanly stop the application.

---

## 12. Interview Questions

1. What is Docker Compose?
2. Why do we use Docker Compose?
3. What is a service in Compose?
4. What is the difference between `docker run` and `docker compose up`?
5. How do containers communicate in Docker Compose?
6. Why are volumes used?
7. What does `docker compose down` do?
8. Where should sensitive configuration be stored?

---

## 13. Summary

- Docker Compose manages **multiple containers as one application**.
- Configuration is defined in `compose.yaml`.
- Services represent application components.
- `docker compose up -d` starts the application.
- `docker compose down` stops and removes the Compose resources.
- Volumes provide persistent storage.
- Services can communicate using their service names.

```text
compose.yaml
     |
     v
Docker Compose
     |
 +---+---+
 |       |
Web     DB
 |       |
Nginx  PostgreSQL
```