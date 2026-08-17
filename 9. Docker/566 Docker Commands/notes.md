# Docker Commands Notes

## 1. Docker Command Structure

Most Docker commands follow:

```text
docker <command> <options>
```

Example:

```bash
docker ps
```

This lists running containers.

---

## 2. Check Docker Installation

```bash
docker --version
```

Example:

```text
Docker version 28.x.x
```

Check more detailed information:

```bash
docker info
```

---

## 3. Image Commands

### 3.1 List Images

```bash
docker images
```

or:

```bash
docker image ls
```

### 3.2 Pull an Image

```bash
docker pull nginx
```

This downloads the Nginx image from a registry such as Docker Hub.

### 3.3 Remove an Image

```bash
docker rmi nginx
```

### 3.4 Inspect an Image

```bash
docker image inspect nginx
```

---

## 4. Container Commands

### 4.1 Run a Container

```bash
docker run nginx
```

Run in the background:

```bash
docker run -d nginx
```

`-d` means **detached mode**.

### 4.2 Give the Container a Name

```bash
docker run -d --name my-nginx nginx
```

### 4.3 List Running Containers

```bash
docker ps
```

### 4.4 List All Containers

```bash
docker ps -a
```

### 4.5 Stop a Container

```bash
docker stop my-nginx
```

### 4.6 Start a Stopped Container

```bash
docker start my-nginx
```

### 4.7 Restart a Container

```bash
docker restart my-nginx
```

### 4.8 Remove a Container

```bash
docker rm my-nginx
```

---

## 5. Container Logs

View logs:

```bash
docker logs my-nginx
```

Follow logs continuously:

```bash
docker logs -f my-nginx
```

`-f` means follow the log output.

---

## 6. Execute Commands Inside a Container

```bash
docker exec -it my-nginx bash
```

If Bash is not available:

```bash
docker exec -it my-nginx sh
```

- `exec` → Execute a command inside a running container.
- `-i` → Interactive.
- `-t` → Allocate a terminal.

Example:

```bash
docker exec -it my-nginx sh
```

Then:

```bash
ls
```

Exit:

```bash
exit
```

---

## 7. Inspect a Container

```bash
docker inspect my-nginx
```

This provides detailed information such as:

- Container configuration
- Network information
- Mounts
- Environment
- Container state

---

## 8. Practical

### Objective

Pull an Nginx image, create a container, verify it, and remove it.

### Step 1: Pull Image

```bash
docker pull nginx
```

### Step 2: Run Container

```bash
docker run -d --name my-nginx nginx
```

### Step 3: Check Container

```bash
docker ps
```

Expected:

```text
CONTAINER ID   IMAGE   STATUS          NAMES
xxxxx          nginx   Up ...          my-nginx
```

### Step 4: Check Logs

```bash
docker logs my-nginx
```

### Step 5: Stop Container

```bash
docker stop my-nginx
```

### Step 6: Remove Container

```bash
docker rm my-nginx
```

### Step 7: Remove Image

```bash
docker rmi nginx
```

**Screenshot:** Add a screenshot showing `docker pull`, `docker run`, and `docker ps`.

---

## 9. Important Commands Cheat Sheet

| Command | Purpose |
|---|---|
| `docker --version` | Check Docker version |
| `docker info` | Docker system information |
| `docker images` | List images |
| `docker pull` | Download image |
| `docker rmi` | Remove image |
| `docker run` | Create and start container |
| `docker ps` | List running containers |
| `docker ps -a` | List all containers |
| `docker stop` | Stop container |
| `docker start` | Start container |
| `docker restart` | Restart container |
| `docker rm` | Remove container |
| `docker logs` | View container logs |
| `docker exec` | Execute command inside container |
| `docker inspect` | Detailed container/image information |

---

## 10. Common Mistakes

- Trying to remove a running container.
- Confusing an image name with a container name.
- Forgetting `-d` when you want the container to run in the background.
- Using `docker ps` and expecting stopped containers to appear.
- Removing an image that is still being used by a container.

---

## 11. Interview Questions

1. What is the difference between `docker run` and `docker start`?
2. What is the difference between `docker ps` and `docker ps -a`?
3. What does `-d` do?
4. What does `docker exec` do?
5. How do you view container logs?
6. How do you remove a container?
7. How do you remove a Docker image?
8. What is the difference between an image and a container?

---

## 12. Summary

The most important commands to remember initially are:

```bash
docker pull
docker images
docker run
docker ps
docker ps -a
docker stop
docker start
docker rm
docker rmi
docker logs
docker exec
docker inspect
```

Basic workflow:

```text
Pull Image
    |
    v
Run Container
    |
    v
docker ps
    |
    v
Logs / Exec / Inspect
    |
    v
Stop → Remove
```