# Docker Persistent Volumes (PV) Notes

## 1. What is Docker PV?

In Docker, containers are generally **temporary**. If a container is removed, data stored inside its writable layer is also removed.

To keep data even after the container is deleted, Docker provides **volumes**.

```text
Container
    |
    | writes data
    v
Docker Volume
    |
    | survives container removal
    v
Persistent Data
```

A Docker volume is the closest Docker concept to **persistent storage**.

---

## 2. Why Do We Need Persistent Storage?

Consider a PostgreSQL container:

```text
PostgreSQL Container
       |
       v
Database Data
```

If the container is removed without persistent storage:

```text
Container removed
       |
       v
Database data lost
```

With a volume:

```text
PostgreSQL Container
       |
       v
Docker Volume
       |
       v
Database data preserved
```

This is important for:

- Databases
- Uploaded files
- Application data
- Logs
- Any data that must survive container recreation

---

## 3. Docker Volume

Create a volume:

```bash
docker volume create app-data
```

List volumes:

```bash
docker volume ls
```

Inspect a volume:

```bash
docker volume inspect app-data
```

Remove a volume:

```bash
docker volume rm app-data
```

---

## 4. Using a Volume

Run a container with a volume:

```bash
docker run -d \
  --name my-nginx \
  -v app-data:/usr/share/nginx/html \
  nginx
```

Here:

```text
app-data
    |
    v
/usr/share/nginx/html
    |
    v
Nginx Container
```

The volume is mounted at `/usr/share/nginx/html` inside the container.

---

## 5. Volume vs Bind Mount

| Volume | Bind Mount |
|---|---|
| Managed by Docker | Uses a specific host path |
| `app-data:/data` | `/home/user/data:/data` |
| Usually preferred for application data | Useful when host files need direct access |
| Easier to manage with Docker | More dependent on host filesystem |

Example volume:

```bash
-v app-data:/data
```

Example bind mount:

```bash
-v /home/ubuntu/data:/data
```

---

## 6. Practical

### Objective

Create a Docker volume, store data in a container, remove the container, and verify that the data remains.

### Step 1: Create Volume

```bash
docker volume create app-data
```

### Step 2: Run Container

```bash
docker run -it \
  --name volume-test \
  -v app-data:/data \
  ubuntu:24.04 \
  bash
```

Inside the container:

```bash
echo "Hello Docker Volume" > /data/test.txt
cat /data/test.txt
```

Expected:

```text
Hello Docker Volume
```

Exit:

```bash
exit
```

### Step 3: Remove Container

```bash
docker rm volume-test
```

### Step 4: Create Another Container Using the Same Volume

```bash
docker run -it \
  --name volume-test-2 \
  -v app-data:/data \
  ubuntu:24.04 \
  bash
```

Inside:

```bash
cat /data/test.txt
```

Expected:

```text
Hello Docker Volume
```

This proves that the data survived the removal of the first container.

**Screenshot:** Add a screenshot showing the file creation, container removal, and successful reading of the file from the second container.

---

## 7. Docker Compose Volume Example

Volumes are commonly used with databases.

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
 Persistent Database
```

---

## 8. Important Commands

| Command | Purpose |
|---|---|
| `docker volume create` | Create volume |
| `docker volume ls` | List volumes |
| `docker volume inspect` | View volume details |
| `docker volume rm` | Remove volume |
| `docker volume prune` | Remove unused volumes |

Be careful with:

```bash
docker volume prune
```

because it removes unused volumes.

---

## 9. Best Practices

- Use volumes for important persistent application data.
- Use named volumes for databases.
- Do not rely on the container's writable layer for important data.
- Take backups of important volumes.
- Be careful before deleting or pruning volumes.
- Don't store secrets simply because they are inside a volume; use proper secret management.

---

## 10. Common Mistakes

- Removing a volume instead of only removing the container.
- Assuming container data is automatically persistent.
- Using bind mounts when a Docker-managed volume is more appropriate.
- Running `docker volume prune` without checking what will be removed.

---

## 11. Interview Questions

1. Why do Docker containers need persistent storage?
2. What is a Docker volume?
3. What happens to container data when the container is removed?
4. What is the difference between a volume and a bind mount?
5. How do you create a Docker volume?
6. How do you mount a volume into a container?
7. Why are volumes commonly used with databases?

---

## 12. Summary

- Containers are usually temporary.
- **Docker volumes provide persistent storage.**
- Data in a volume can survive container deletion.
- Volumes are commonly used for databases and application data.
- Docker manages the storage location of named volumes.
- Bind mounts directly connect a host path to a container path.

```text
Container 1
    |
    v
Volume
    |
    | container removed
    v
Volume still exists
    |
    v
Container 2
    |
    v
Same data available
```
```