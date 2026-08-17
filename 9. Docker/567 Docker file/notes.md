# Dockerfile Notes

## 1. What is a Dockerfile?

A **Dockerfile** is a text file containing instructions used to build a Docker image.

```text
Dockerfile
    |
    | docker build
    v
Docker Image
    |
    | docker run
    v
Container
```

Instead of manually configuring a container every time, we define the setup in a Dockerfile and create a reusable image.

---

## 2. Basic Dockerfile Structure

Example:

```dockerfile
FROM ubuntu:24.04

WORKDIR /app

COPY . .

RUN apt update && apt install -y nginx

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
```

### Important Instructions

| Instruction | Purpose |
|---|---|
| `FROM` | Defines the base image |
| `WORKDIR` | Sets the working directory |
| `COPY` | Copies files into the image |
| `RUN` | Executes commands while building |
| `EXPOSE` | Documents the application's port |
| `CMD` | Default command when container starts |
| `ENTRYPOINT` | Defines the main executable |

---

## 3. Important Instructions

### 3.1 `FROM`

Every Dockerfile normally starts with a base image.

```dockerfile
FROM ubuntu:24.04
```

It provides the starting environment for the image.

### 3.2 `WORKDIR`

Sets the working directory inside the image/container.

```dockerfile
WORKDIR /app
```

### 3.3 `COPY`

Copies files from the build context into the image.

```dockerfile
COPY . .
```

### 3.4 `RUN`

Runs a command **during image building**.

```dockerfile
RUN apt update && apt install -y curl
```

### 3.5 `CMD`

Defines the default command when the container starts.

```dockerfile
CMD ["nginx", "-g", "daemon off;"]
```

### 3.6 `EXPOSE`

Documents which port the application listens on.

```dockerfile
EXPOSE 8080
```

`EXPOSE` does **not** publish the port to the host by itself.

---

## 4. Practical Example

### Objective

Create a simple Docker image containing an Nginx web server.

### Step 1: Create Directory

```bash
mkdir docker-demo
cd docker-demo
```

### Step 2: Create Dockerfile

```dockerfile
FROM nginx:alpine

COPY index.html /usr/share/nginx/html/index.html

EXPOSE 80
```

### Step 3: Create `index.html`

```html
<!DOCTYPE html>
<html>
<head>
    <title>Docker Demo</title>
</head>
<body>
    <h1>Hello from Docker!</h1>
</body>
</html>
```

### Step 4: Build Image

```bash
docker build -t my-nginx .
```

Explanation:

- `docker build` → Builds an image.
- `-t my-nginx` → Gives the image a name/tag.
- `.` → Uses the current directory as the build context.

### Step 5: Verify Image

```bash
docker images
```

You should see:

```text
REPOSITORY   TAG       IMAGE ID       ...
my-nginx     latest    xxxxx          ...
```

### Step 6: Run Container

```bash
docker run -d --name my-web -p 8080:80 my-nginx
```

Port mapping:

```text
Host Port 8080
      |
      v
Container Port 80
      |
      v
Nginx
```

Open:

```text
http://localhost:8080
```

You should see:

```text
Hello from Docker!
```

**Screenshot:** Add a screenshot of the Docker build output and the webpage running on `localhost:8080`.

---

## 5. `.dockerignore`

`.dockerignore` prevents unnecessary files from being sent to the Docker build context.

Example:

```text
.git
.gitignore
node_modules
*.log
.env
```

This helps:

- Reduce build context size.
- Improve build speed.
- Avoid copying unnecessary or sensitive files.

---

## 6. `CMD` vs `ENTRYPOINT`

Both define what happens when a container starts.

### `CMD`

Provides a default command that can easily be overridden.

```dockerfile
CMD ["nginx", "-g", "daemon off;"]
```

### `ENTRYPOINT`

Defines the main executable of the container.

```dockerfile
ENTRYPOINT ["python3"]
```

Simple way to remember:

```text
CMD        → Default command
ENTRYPOINT → Main executable
```

---

## 7. Best Practices

- Use small trusted base images when appropriate.
- Add a `.dockerignore` file.
- Avoid unnecessary packages.
- Keep Dockerfiles simple.
- Use specific image tags instead of relying on `latest` for production.
- Combine related package installation commands where appropriate.
- Don't store secrets inside Dockerfiles.
- Use multi-stage builds for applications that require a build environment.

---

## 8. Common Mistakes

- Forgetting the `FROM` instruction.
- Using incorrect paths in `COPY`.
- Assuming `EXPOSE` publishes a port.
- Putting application secrets inside the Dockerfile.
- Copying unnecessary files into the image.
- Using `RUN` when the command should execute when the container starts.

---

## 9. Interview Questions

1. What is a Dockerfile?
2. What is the purpose of `FROM`?
3. Difference between `RUN` and `CMD`?
4. Difference between `CMD` and `ENTRYPOINT`?
5. What does `COPY` do?
6. What is `WORKDIR`?
7. Does `EXPOSE` publish a port?
8. What is `.dockerignore`?
9. How do you build a Docker image from a Dockerfile?

---

## 10. Summary

- **Dockerfile** → Instructions for building an image.
- `FROM` → Base image.
- `RUN` → Executes during image build.
- `COPY` → Copies files into the image.
- `WORKDIR` → Sets working directory.
- `EXPOSE` → Documents container port.
- `CMD` → Default startup command.
- `ENTRYPOINT` → Main executable.
- `docker build` converts the Dockerfile into an image.
- The image can then be used to create containers.